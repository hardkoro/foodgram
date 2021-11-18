from django.contrib.auth import get_user_model
from djoser.views import UserViewSet
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from api.pagination import LimitPageNumberPagination
from users.models import Follow
from users.serializers import CustomUserSerializer, FollowSerializer

User = get_user_model()


class CustomUserViewSet(UserViewSet):
    queryset = User.objects.all()
    serializer_class = CustomUserSerializer
    pagination_class = LimitPageNumberPagination

    @action(methods=['GET', 'DELETE'], detail=True)
    def subscribe(self, request, id):
        author = get_object_or_404(User, id=id)
        if request.method == 'DELETE':
            get_object_or_404(
                Follow, user=request.user, author__id=id
            ).delete()
            return Response(
                data=f'{request.user} unfollowed {request.author}',
                status=status.HTTP_204_NO_CONTENT
            )
        serializer = FollowSerializer(
            data={
                'user': request.user.id,
                'author': author
            }
        )
        serializer.is_valid(raise_exception=True)
        serializer.save(user=request.user)
        return Response(
            data=serializer.data,
            status=status.HTTP_201_CREATED
        )

    @action(methods=['GET'], detail=False, permission_classes=[IsAuthenticated])
    def subscriptions(self, request):
        user = request.user
        queryset = Follow.objects.filter(user=user)
        pages = self.paginate_queryset(queryset)
        serializer = FollowSerializer(
            pages, many=True, context={'request': request}
        )
        return self.get_paginated_response(serializer.data)
