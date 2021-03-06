# Generated by Django 3.2.9 on 2021-11-18 17:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20211118_1913'),
    ]

    operations = [
        migrations.RemoveConstraint(
            model_name='ingredient',
            name='unique ingredient+measurement pair',
        ),
        migrations.RemoveConstraint(
            model_name='ingredientinrecipe',
            name='unique ingredient in recipe',
        ),
        migrations.RemoveConstraint(
            model_name='recipefavorite',
            name='unique recipe in favorites',
        ),
        migrations.RemoveConstraint(
            model_name='recipeincart',
            name='unique recipe in cart',
        ),
        migrations.AddConstraint(
            model_name='ingredient',
            constraint=models.UniqueConstraint(fields=('name', 'measurement_unit'), name='unique ingredient & measurement pair'),
        ),
        migrations.AddConstraint(
            model_name='ingredientinrecipe',
            constraint=models.UniqueConstraint(fields=('recipe', 'ingredient'), name='unique Ingredient in Recipe'),
        ),
        migrations.AddConstraint(
            model_name='recipefavorite',
            constraint=models.UniqueConstraint(fields=('user', 'recipe'), name='unique Recipe in favorites'),
        ),
        migrations.AddConstraint(
            model_name='recipeincart',
            constraint=models.UniqueConstraint(fields=('user', 'recipe'), name='unique Recipe in cart'),
        ),
    ]
