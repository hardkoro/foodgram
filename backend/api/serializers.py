from rest_framework import serializers, validators

from .models import Ingredient, IngredientInRecipe, Recipe, Tag
from users.serializers import CustomUserSerializer


class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ('name', 'id', 'color', 'slug')


class IngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ingredient
        fields = ('name', 'measurement_unit', 'id')


class IngredientInRecipeSerializer(serializers.ModelSerializer):
    name = serializers.ReadOnlyField(source='ingredient.name')
    measurement_unit = serializers.ReadOnlyField(
        source='ingredient.measurement_unit'
    )
    id = serializers.ReadOnlyField(source='ingredient.id')
    class Meta:
        model = IngredientInRecipe
        fields = ('name', 'measurement_unit', 'id', 'amount')
        validators = [
            validators.UniqueTogetherValidator(
                queryset=IngredientInRecipe.objects.all(),
                fields=['ingredient', 'recipe']
            )
        ]


class RecipeSerializer(serializers.ModelSerializer):
    tags = TagSerializer(
        read_only=True,
        many=True
    )
    author = CustomUserSerializer()
    is_favorited = serializers.BooleanField(
        read_only=True,
        default=False
    )
    is_in_shopping_cart = serializers.BooleanField(
        read_only=True,
        default=False
    )
    ingredients = IngredientInRecipeSerializer(
        read_only=True,
        many=True
    )

    class Meta:
        model = Recipe
        fields = (
            'tags', 'author', 'is_favorited', 'is_in_shopping_cart',
            'name', 'image', 'text', 'cooking_time', 'id', 'ingredients'
        )
