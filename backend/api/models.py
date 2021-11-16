from django.contrib.auth import get_user_model
from django.core.validators import MinValueValidator
from django.db import models
from django.db.models.fields.related import ForeignKey

User = get_user_model()


class Tag(models.Model):
    """
    Model to tag Recipe objects.
    Each Recipe object may be tagged with multiple Tags.
    """
    name = models.CharField(unique=True, max_length=200)
    color = models.CharField(unique=True, max_length=7)
    slug = models.SlugField(unique=True, max_length=200)

    class Meta:
        ordering = ['-id']

    def __str__(self):
        return self.name

    def __repr__(self):
        return self.name


class Ingredient(models.Model):
    """
    Model of Ingredients. May contain multiple records of one component
    but with different measurement units, e.g. "potato, kg" & "potato, pc"
    """
    name = models.CharField(
        null=False,
        blank=False,
        db_index=True,
        max_length=200
    )
    measurement_unit = models.CharField(
        null=False,
        blank=False,
        max_length=200
    )

    class Meta:
        # Ingredient & Measurement combination must be unique
        constraints = [
            models.UniqueConstraint(
                fields=['name', 'measurement_unit'],
                name='unique ingredient+measurement pair'
            )
        ]
        ordering = ['name']

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
        null=False,
        blank=False
    )
    name = models.CharField(
        max_length=200,
        null=False,
        blank=False
    )
    image = models.ImageField(
        upload_to='recipes/',
        null=False,
        blank=False
    )
    text = models.TextField(null=False, blank=False)
    cooking_time = models.PositiveSmallIntegerField(
        null=False,
        blank=False,
        db_index=True,
        validators=[
            MinValueValidator(1, 'Cooking time must be at least 1 minute!')
        ]
    )
    tags = models.ManyToManyField(Tag)
    ingredients = models.ManyToManyField(
        Ingredient,
        through='IngredientInRecipe'
    )

    class Meta:
        ordering = ['-id']

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
        blank=False,
        null=False
    )
    ingredient = ForeignKey(
        Ingredient,
        on_delete=models.DO_NOTHING,
        blank=False,
        null=False
    )
    amount = models.PositiveSmallIntegerField(
        null=True,
        blank=True,
        validators=[
            MinValueValidator(1, 'Ingredient amount must be at least 1!')
        ]
    )

    class Meta:
        # Ingredient & Measurement combination must be unique
        constraints = [
            models.UniqueConstraint(
                fields=['recipe', 'ingredient'],
                name='unique ingredient in recipe'
            )
        ]
        ordering = ['id']

    def __str__(self):
        return f'{self.recipe}: {self.ingredient} {self.amount}'

    def __repr__(self):
        return f'{self.recipe}: {self.ingredient} {self.amount}'
