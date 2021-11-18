from django.urls import include, path
from rest_framework.routers import DefaultRouter

from users.views import CustomUserViewSet

router = DefaultRouter()
router.register('users', CustomUserViewSet)

login = DefaultRouter()

urlpatterns = [
    path('', include(router.urls)),
]
