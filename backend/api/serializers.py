from drf_extra_fields.fields import Base64ImageField
from rest_framework import serializers, validators
from rest_framework.generics import get_object_or_404

from api.fields import Hex2NameColor
from api.models import Ingredient, IngredientInRecipe, Recipe, Tag
from users.models import Follow
from users.serializers import CustomUserSerializer

NO_INGREDIENTS_ERROR = 'Can\'t add Recipe without Ingredients!'
OBJECT_EXISTS = 'Can\'t add the same {object_name} twice!'
WRONG_NUMERICAL_VALUE = '{value_name} must be greater than zero!'


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

    def validate_ingredients(self, data):
        if not data:
            raise serializers.ValidationError(
                {'ingredients': OBJECT_EXISTS.format(object_name='Ingredient')}
            )

        valid_ingredients = []
        for item in data:
            ingredient = get_object_or_404(
                Ingredient, id=item['id']
            )
            if ingredient in valid_ingredients:
                raise serializers.ValidationError(
                    {'ingredients': OBJECT_EXISTS.format(
                        object_name='Ingredient'
                    )}
                )
            if not int(ingredient['amount'] > 0):
                raise serializers.ValidationError(
                    {'ingredients': WRONG_NUMERICAL_VALUE(
                        value_name='Ingredient amount'
                    )}
                )
            valid_ingredients.append(ingredient)
        return data

    def validate_tags(self, data):
        valid_tags = []
        for tag in data:
            if tag in valid_tags:
                raise serializers.ValidationError(
                    {'tags': OBJECT_EXISTS.format(object_name='Tag')}
                )
            valid_tags.append(tag)
        return data

    def validate_cooking_time(self, data):
        if not (int(data) > 0):
            raise serializers.ValidationError(
                {'cooking_time': WRONG_NUMERICAL_VALUE(
                    value_name='Cooking time'
                )}
            )
        return data

    def add_ingredients(self, recipe, ingredients):
        for item in ingredients:
            ingredient = get_object_or_404(Ingredient, id=item.get('id'))
            IngredientInRecipe.objects.create(
                recipe=recipe,
                ingredient=ingredient,
                amount=item.get('amount')
            )

    def create(self, validated_data):
        print(self.initial_data)
        ingredients = self.initial_data.get('ingredients')
        recipe = Recipe.objects.create(**validated_data)
        tags = self.initial_data.get('tags')
        recipe.tags.set(tags)
        self.add_ingredients(recipe, ingredients)
        return recipe

    def update(self, recipe, validated_data):
        IngredientInRecipe.objects.filter(recipe=recipe).delete()
        ingredients = self.initial_data.get('ingredients')
        self.add_ingredients(recipe, ingredients)
        recipe.tags.clear()
        tags = self.initial_data.get('tags')
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
