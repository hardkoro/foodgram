from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated

from .exports import export_shopping_list_to_pdf
from .filters import IngredientNameSearchFilter, RecipeAuthorAndTagFilter
from .models import (Ingredient, IngredientInRecipe, Recipe, RecipeFavorite,
                     RecipeInCart, Tag)
from .pagination import LimitPageNumberPagination
from .permissions import IsAdminOrAuthorOrReadOnly, IsAdminOrReadOnly
from .serializers import IngredientSerializer, RecipeSerializer, TagSerializer
from .utils import get_or_delete_recipe_submodel_object


class IngredientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer
    permission_classes = (IsAdminOrReadOnly, )
    filter_backends = (IngredientNameSearchFilter, )
    search_fields = ('name', )


class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializer
    pagination_class = LimitPageNumberPagination
    filter_class = RecipeAuthorAndTagFilter
    permissions = (IsAdminOrAuthorOrReadOnly, )

    def perform_create(self, serializer):
        serializer.save(author=self.request.user)

    @action(
        methods=['GET'], detail=False,
        permissions=[IsAuthenticated]
    )
    def download_shopping_cart(self, request):
        shopping_cart = {}
        ingredients = IngredientInRecipe.objects.filter(
            recipe__in_cart__user=request.user
        ).values_list(
            'ingredient__name',
            'ingredient__measurement_unit',
            'amount'
        ).order_by('ingredient__name')
        for ingredient in ingredients:
            name = ingredient[0]
            if name in shopping_cart:
                shopping_cart[name]['amount'] += ingredient[2]
            else:
                shopping_cart[name] = {
                    'measurement_unit': ingredient[1],
                    'amount': ingredient[2]
                }
        return export_shopping_list_to_pdf(shopping_cart)

    @action(
        methods=['GET', 'DELETE'], detail=True,
        permissions=[IsAuthenticated]
    )
    def shopping_cart(self, request, pk):
        return get_or_delete_recipe_submodel_object(
            RecipeInCart, request, pk
        )

    @action(
        methods=['GET', 'DELETE'], detail=True,
        permissions=[IsAuthenticated]
    )
    def favorite(self, request, pk):
        return get_or_delete_recipe_submodel_object(
            RecipeFavorite, request, pk
        )


class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = (IsAdminOrReadOnly, )
