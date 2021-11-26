from django.contrib.auth import get_user_model
from django.core.validators import MinValueValidator
from django.db import models
from django.db.models.fields.related import ForeignKey
from django.utils.text import slugify

User = get_user_model()


class Tag(models.Model):
    """
    Model to tag Recipe objects.
    Each Recipe object may be tagged with multiple Tags.
    """
    name = models.CharField(unique=True, max_length=200, verbose_name='name')
    color = models.CharField(unique=True, max_length=7, verbose_name='color')
    slug = models.SlugField(unique=True, max_length=200, verbose_name='slug')

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super(Tag, self).save(*args, **kwargs)

    class Meta:
        ordering = ['-id']
        verbose_name = 'Tag'
        verbose_name_plural = 'Tags'

    def __str__(self):
        return self.name

    def __repr__(self):
        return self.name


class Ingredient(models.Model):
    """
    Model of Ingredients. May contain multiple records of one component
    but with different measurement units, e.g. "potato, kg" & "potato, pc"
    """
    name = models.CharField(db_index=True, max_length=200, verbose_name='name')
    measurement_unit = models.CharField(
        max_length=200,
        verbose_name='measure_unit'
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['name', 'measurement_unit'],
                name='unique ingredient & measurement pair'
            )
        ]
        ordering = ['name']
        verbose_name = 'Ingredient'
        verbose_name_plural = 'Ingredients'

    def __str__(self):
        return f'{self.name}, {self.measurement_unit}'

    def __repr__(self):
        return f'{self.name}, {self.measurement_unit}'


class Recipe(models.Model):
    """Main model of dishes to cook."""
    author = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='recipes',
        verbose_name='author'
    )
    name = models.CharField(max_length=200, verbose_name='name')
    image = models.ImageField(upload_to='recipes/', verbose_name='image')
    text = models.TextField(verbose_name='text')
    cooking_time = models.PositiveSmallIntegerField(
        db_index=True,
        validators=[
            MinValueValidator(1, 'Cooking time must be at least 1 minute!')
        ],
        verbose_name='cooking_time'
    )
    tags = models.ManyToManyField(Tag, verbose_name='tags')
    ingredients = models.ManyToManyField(
        Ingredient,
        through='IngredientInRecipe',
        verbose_name='ingredients'
    )

    class Meta:
        ordering = ['-id']
        verbose_name = 'Recipe'
        verbose_name_plural = 'Recipes'

    def __str__(self):
        return f'{self.name} by {self.author}'

    def __repr__(self):
        return f'{self.name} by {self.author}'


class IngredientInRecipe(models.Model):
    """
    Model to connect Recipe object with its Ingredients & respective quantity
    """
    recipe = ForeignKey(
        Recipe,
        on_delete=models.CASCADE,
        verbose_name='recipe'
    )
    ingredient = ForeignKey(
        Ingredient,
        on_delete=models.DO_NOTHING,
        verbose_name='ingredient'
    )
    amount = models.PositiveSmallIntegerField(
        null=True,
        blank=True,
        validators=[
            MinValueValidator(1, 'Ingredient amount must be at least 1!')
        ],
        verbose_name='amount'
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['recipe', 'ingredient'],
                name='unique Ingredient in Recipe'
            )
        ]
        ordering = ['id']
        verbose_name = 'Ingredient in Recipe'
        verbose_name_plural = 'Ingredients in Recipes'

    def __str__(self):
        return f'{self.recipe}: {self.ingredient} {self.amount}'

    def __repr__(self):
        return f'{self.recipe}: {self.ingredient} {self.amount}'


class RecipeFavorite(models.Model):
    """
    Model to store favorited by User Recipe objects
    """
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='user'
    )
    recipe = models.ForeignKey(
        Recipe,
        on_delete=models.CASCADE,
        related_name='favorites',
        verbose_name='favorites'
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['user', 'recipe'],
                name='unique Recipe in favorites'
            )
        ]
        ordering = ['-id']
        verbose_name = 'Favorited Recipe'
        verbose_name_plural = 'Favorited Recipes'

    def __str__(self):
        return f'{self.user}: {self.recipe.name}'

    def __repr__(self):
        return f'{self.user}: {self.recipe.name}'


class RecipeInCart(models.Model):
    """
    Model to store Recipe objects added by User to Cart
    """
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='user'
    )
    recipe = models.ForeignKey(
        Recipe,
        on_delete=models.CASCADE,
        related_name='in_cart',
        verbose_name='in_cart'
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['user', 'recipe'],
                name='unique Recipe in cart'
            )
        ]
        ordering = ['-id']
        verbose_name = 'Recipe in Cart'
        verbose_name_plural = 'Recipes in Cart'

    def __str__(self):
        return f'{self.user}: {self.recipe.name}'

    def __repr__(self):
        return f'{self.user}: {self.recipe.name}'
