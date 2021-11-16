from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters, viewsets
from rest_framework.decorators import action
from rest_framework.pagination import PageNumberPagination

from .mixins import CreateRetrieveListViewSet
from .models import Ingredient, Recipe, Tag
from .permissions import IsAdminOrAuthorOrReadOnly, IsAdminOrReadOnly
from .serializers import IngredientSerializer, RecipeSerializer, TagSerializer


class IngredientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer
    permission_classes = (IsAdminOrReadOnly, )
    filter_backends = (DjangoFilterBackend, filters.SearchFilter)
    filterset_fields = ('name', )
    search_fields = ('^name', )


class RecipeViewSet(CreateRetrieveListViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializer
    pagination = PageNumberPagination
    filter_backends = (DjangoFilterBackend, )
    permissions = (IsAdminOrAuthorOrReadOnly, )
    # filterset_fields = ('author')

    def perform_create(self, serializer):
        serializer.save(author=self.request.user)

    @action(detail=False)
    def download_shopping_cart(self, request):
        pass

    @action(methods=['GET', 'DELETE'], detail=True)
    def shopping_cart(self, request):
        pass

    @action(methods=['GET', 'DELETE'], detail=True)
    def favorite(self, request):
        pass


class TagViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = (IsAdminOrReadOnly, )
