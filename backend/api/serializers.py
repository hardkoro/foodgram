from drf_extra_fields.fields import Base64ImageField
from rest_framework import serializers, validators
from rest_framework.generics import get_object_or_404

from api.fields import Hex2NameColor
from api.models import Ingredient, IngredientInRecipe, Recipe, Tag
from users.models import Follow
from users.serializers import CustomUserSerializer

NO_INGREDIENTS_ERROR = 'Can\'t add Recipe without Ingredients!'
INGREDIENT_EXISTS = 'Can\'t add the same Ingredient twice!'
WRONG_INGREDIENT_AMOUNT = 'Ingredient amount must be greater than zero!'
TAG_EXISTS = 'Can\'t add the same Tag twice!'
WRONG_COOKING_TIME = 'Cooking time must be greater than zero!'


class TagSerializer(serializers.ModelSerializer):
    color = Hex2NameColor()

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
    is_favorited = serializers.SerializerMethodField()
    is_in_shopping_cart = serializers.SerializerMethodField()
    image = Base64ImageField()
    ingredients = IngredientInRecipeSerializer(
        source='ingredientinrecipe_set',
        read_only=True,
        many=True
    )

    def get_is_favorited(self, obj):
        user = self.context.get('request').user
        if user.is_anonymous:
            return False
        return Recipe.objects.filter(favorites__user=user, id=obj.id).exists()

    def get_is_in_shopping_cart(self, obj):
        user = self.context.get('request').user
        if user.is_anonymous:
            return False
        return Recipe.objects.filter(in_cart__user=user, id=obj.id).exists()

    class Meta:
        model = Recipe
        fields = (
            'tags', 'author', 'is_favorited', 'is_in_shopping_cart',
            'name', 'image', 'text', 'cooking_time', 'id', 'ingredients'
        )

    def validate(self, attrs):
        ingredients = self.initial_data.get('ingredients')
        if not ingredients:
            raise serializers.ValidationError(
                {'ingredients': NO_INGREDIENTS_ERROR}
            )

        valid_ingredients = []
        for item in ingredients:
            ingredient = get_object_or_404(
                Ingredient, id=item['id']
            )
            if ingredient in valid_ingredients:
                raise serializers.ValidationError(
                    {'ingredients': INGREDIENT_EXISTS}
                )
            if not int(ingredient['amount'] > 0):
                raise serializers.ValidationError(
                    {'ingredients': WRONG_INGREDIENT_AMOUNT}
                )
            valid_ingredients.append(ingredient)
        attrs['ingredients'] = ingredients

        tags = self.initial_data.get('tags')
        valid_tags = []
        for tag in tags:
            if tag in valid_tags:
                raise serializers.ValidationError(
                    {'tags': TAG_EXISTS}
                )
            valid_tags.append(tag)
        attrs['tags'] = tags

        cooking_time = self.initial_data.get('cooking_time')
        if not (int(cooking_time) > 0):
            raise serializers.ValidationError(
                {'cooking_time': WRONG_COOKING_TIME}
            )
        attrs['cooking_time'] = cooking_time

        return attrs

    def add_ingredients(self, recipe, ingredients):
        for item in ingredients:
            ingredient = get_object_or_404(Ingredient, id=item.get('id'))
            IngredientInRecipe.objects.create(
                recipe=recipe,
                ingredient=ingredient,
                amount=item.get('amount')
            )

    def create(self, validated_data):
        ingredients = validated_data.pop('ingredients')
        recipe = Recipe.objects.create(**validated_data)
        tags = validated_data.pop('tags')
        recipe.tags.set(tags)
        self.add_ingredients(recipe, ingredients)
        return recipe

    def update(self, recipe, validated_data):
        IngredientInRecipe.objects.filter(recipe=recipe).delete()
        ingredients = validated_data.pop('ingredients')
        self.add_ingredients(recipe, ingredients)
        recipe.tags.clear()
        tags = validated_data.pop('tags')
        recipe.tags.set(tags)
        return super().update(recipe, validated_data)


class RecipeShortSerializer(serializers.ModelSerializer):
    """Short bersion of Recipe serializer for Follow creation response."""

    class Meta:
        model = Recipe
        fields = (
            'id', 'name', 'image', 'cooking_time'
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
        return Follow.objects.filter(user=obj.user, author=obj.author).exists()

    def get_recipes(self, obj):
        request = self.context.get('request')
        limit = request.GET.get('recipes_limit')
        queryset = Recipe.objects.filter(author=obj.author)
        if limit:
            queryset = queryset[:int(limit)]
        return RecipeShortSerializer(queryset, many=True).data

    def get_recipes_count(self, obj):
        return Recipe.objects.filter(author=obj.author).count()
