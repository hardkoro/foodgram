from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.generics import get_object_or_404
from rest_framework.response import Response

from .filters import IngredientNameFilter, RecipeAuthorAndTagFilter
from .models import Ingredient, Recipe, RecipeFavorite, RecipeInCart, Tag
from .pagination import LimitPageNumberPagination
from .permissions import IsAdminOrAuthorOrReadOnly, IsAdminOrReadOnly
from .serializers import (IngredientSerializer, RecipeSerializer,
                          RecipeShortSerializer, TagSerializer)

ERROR_OBJECT_EXISTS = 'Can\'t add recipe to {model_name} twice!'
ERROR_NO_OBJECT = (
    'Can\'t remove recipe from {model_name} because it is not in {model_name}!'
)


class IngredientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer
    permission_classes = (IsAdminOrReadOnly, )
    filter_class = IngredientNameFilter


class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializer
    pagination_class = LimitPageNumberPagination
    filter_class = RecipeAuthorAndTagFilter
    permissions = (IsAdminOrAuthorOrReadOnly, )

    def perform_create(self, serializer):
        serializer.save(author=self.request.user)

    @action(detail=False)
    def download_shopping_cart(self, request):
        pass

    @action(methods=['GET', 'DELETE'], detail=True)
    def shopping_cart(self, request, pk):
        return get_or_delete_recipe_submodel_object(
            RecipeInCart, request, pk
        )

    @action(methods=['GET', 'DELETE'], detail=True)
    def favorite(self, request, pk):
        return get_or_delete_recipe_submodel_object(
            RecipeFavorite, request, pk
        )


class TagViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = (IsAdminOrReadOnly, )


def get_or_delete_recipe_submodel_object(Model, request, pk):
    """
    GET or DELETE requests handlers for Recipe sub-model Model
    (e.g. RecipeFavorite or RecipeInCart)
    """
    user, recipe = request.user, get_object_or_404(Recipe, pk=pk)
    object = Model.objects.filter(user=user, recipe=recipe)

    if request.method == 'GET':
        if object.exists():
            return Response(
                data={
                    'errors': ERROR_OBJECT_EXISTS.format(
                        model_name=Model.__name__
                    )
                },
                status=status.HTTP_400_BAD_REQUEST
            )
        object = Model.objects.create(user=user, recipe=recipe)
        serializer = RecipeShortSerializer(
            recipe, context={'request': request}
        )
        return Response(
            data=serializer.data,
            status=status.HTTP_201_CREATED
        )
    if not object:
        return Response(
            data={
                'errors': ERROR_NO_OBJECT.format(
                    model_name=Model.__name__
                )
            },
            status=status.HTTP_400_BAD_REQUEST
        )
    object.delete()
    return Response(status=status.HTTP_204_NO_CONTENT)
