from rest_framework import serializers, validators

from users.models import Follow
from users.serializers import CustomUserSerializer

from .models import Ingredient, IngredientInRecipe, Recipe, Tag


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
    author = CustomUserSerializer(read_only=True)
    # is_favorited = serializers.SerializerMethodField()
    # is_in_shopping_cart = serializers.SerializerMethodField()
    ingredients = IngredientInRecipeSerializer(
        source='ingredientinrecipe_set',
        read_only=True,
        many=True
    )

    # def get_is_favorited(self, obj):
    #     user = self.context['request'].user
    #     if user.is_anonymous():
    #         return False
    #     return Recipe.objects.filter(favorites__user=user, id=obj.id).exists()

    # def get_is_in_shopping_cart(self, obj):
    #     user = self.context['request'].user
    #     if user.is_anonymous():
    #         return False
    #     return Recipe.objects.filter(cart__user=user, id=obj.id).exists()

    class Meta:
        model = Recipe
        fields = (
            'tags', 'author', # 'is_favorited', 'is_in_shopping_cart',
            'name', 'image', 'text', 'cooking_time', 'id', 'ingredients'
        )


class FollowSerializer(serializers.ModelSerializer):
    email = serializers.ReadOnlyField(source='author.email')
    id = serializers.ReadOnlyField(source='author.id')
    username = serializers.ReadOnlyField(source='author.username')
    first_name = serializers.ReadOnlyField(source='author.first_name')
    last_name = serializers.ReadOnlyField(source='author.last_name')
    is_subscribed = serializers.SerializerMethodField()
    recipes = serializers.SerializerMethodField()
    recipes_count = serializers.SerializerMethodField()

    class Meta:
        model = Follow
        fields = (
            'email', 'id', 'username', 'first_name', 'last_name',
            'is_subscribed', 'recipes', 'recipes_count'
        )

    def get_is_subscribed(self, obj):
        return True

    def get_recipes(self, obj):
        queryset = Recipe.objects.filter(author=obj.author)
        print(obj, obj.author, queryset)
        return RecipeSerializer(queryset, many=True).data

    def get_recipes_count(self, obj):
        return Recipe.objects.filter(author=obj.author).count()
