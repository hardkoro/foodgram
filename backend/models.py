from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator
from django.db import models
from django.db.models.fields.related import ForeignKey


class User(AbstractUser):
    """Extend User model with custom fields."""
    email = models.EmailField(unique=True)

    class Meta:
        # Username & Email combination must be unique
        constraints = [
            models.UniqueConstraint(
                fields=['username', 'email'],
                name='one_email_one_account'
            )
        ]
        ordering = ['username']

    def __str__(self):
        return self.username

    def __repr__(self):
        return self.username


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
                name='unique_ingredient_measurement_pair'
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
        upload_to='media/recipes/',
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
        related_name='ingredients',
        blank=False,
        null=False
    )
    ingredient = ForeignKey(
        Ingredient,
        on_delete=models.DO_NOTHING,
        related_name='used_in_recipes',
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
                name='unique_ingredient_in_recipe'
            )
        ]
        ordering = ['id']

    def __str__(self):
        return f'{self.recipe}: {self.ingredient} {self.amount}'

    def __repr__(self):
        return f'{self.recipe}: {self.ingredient} {self.amount}'
