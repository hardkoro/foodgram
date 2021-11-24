from rest_framework import status
from rest_framework.generics import get_object_or_404
from rest_framework.response import Response

from .models import Recipe
from .serializers import RecipeShortSerializer

ERROR_OBJECT_EXISTS = 'Can\'t add recipe to {model_name} twice!'
ERROR_NO_OBJECT = (
    'Can\'t remove recipe from {model_name} because it is not in {model_name}!'
)


def get_or_delete_recipe_submodel_object(model, request, pk):
    """
    GET or DELETE requests handlers for Recipe sub-model Model
    (e.g. RecipeFavorite or RecipeInCart)
    """
    user, recipe = request.user, get_object_or_404(Recipe, pk=pk)
    object = model.objects.filter(user=user, recipe=recipe)

    if request.method == 'GET':
        if object.exists():
            return Response(
                data={
                    'errors': ERROR_OBJECT_EXISTS.format(
                        model_name=model.__name__
                    )
                },
                status=status.HTTP_400_BAD_REQUEST
            )
        object = model.objects.create(user=user, recipe=recipe)
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
                    model_name=model.__name__
                )
            },
            status=status.HTTP_400_BAD_REQUEST
        )
    object.delete()
    return Response(status=status.HTTP_204_NO_CONTENT)
