from django.contrib.auth import get_user_model
from djoser.serializers import TokenSerializer
from djoser.views import UserViewSet
from rest_framework.decorators import permission_classes
from rest_framework.views import APIView
from rest_framework import permissions, serializers


User = get_user_model()


class CustomUserViewSet(UserViewSet):
    queryset = User.objects.all()


class TokenAPI(APIView):
    permission_classes = (permissions.AllowAny, )

    def post(self, request):
        serializers = TokenSerializer(data=request.data)
