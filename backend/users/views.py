from django.contrib.auth import get_user_model
from djoser.views import UserViewSet
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from api.pagination import LimitPageNumberPagination
from api.permissions import IsAdminOrAuthorOrReadOnly
from api.serializers import FollowSerializer
from users.models import Follow

User = get_user_model()

ERROR_SUBSCRIPTION_TO_SELF = 'Can\'t subscribe to self!'
ERROR_SUBSCRIPTION_EXISTS = 'Can\'t subscribe to the same author twice!'
ERROR_NO_SUBSCRIPTION = (
    'Can\'t unsubscribe author because it is not in subscriptions!'
)


class CustomUserViewSet(UserViewSet):
    permission_classes = (IsAdminOrAuthorOrReadOnly, )
    pagination_class = LimitPageNumberPagination

    @action(
        methods=['GET', 'DELETE'], detail=True,
        permission_classes=[IsAuthenticated]
    )
    def subscribe(self, request, id):
        user, author = request.user, get_object_or_404(User, id=id)
        follow = Follow.objects.filter(user=user, author=author)

        if request.method == 'GET':
            if user == author:
                return Response(
                    data={
                        'errors': ERROR_SUBSCRIPTION_TO_SELF
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )
            if follow.exists():
                return Response(
                    data={
                        'errors': ERROR_SUBSCRIPTION_EXISTS
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )
            follow = Follow.objects.create(user=user, author=author)
            serializer = FollowSerializer(
                follow, context={'request': request}
            )
            return Response(
                data=serializer.data,
                status=status.HTTP_201_CREATED
            )
        if not follow:
            return Response(
                data={
                    'errors': ERROR_NO_SUBSCRIPTION
                },
                status=status.HTTP_400_BAD_REQUEST
            )
        follow.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    @action(
        methods=['GET'], detail=False,
        permission_classes=[IsAuthenticated]
    )
    def subscriptions(self, request):
        user = request.user
        queryset = Follow.objects.filter(user=user)
        pages = self.paginate_queryset(queryset)
        serializer = FollowSerializer(
            pages, many=True, context={'request': request}
        )
        return self.get_paginated_response(serializer.data)
