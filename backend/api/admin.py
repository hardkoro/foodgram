from django.contrib import admin

from .models import (Ingredient, IngredientInRecipe, Recipe, RecipeFavorite,
                     RecipeInCart, Tag)


class IngredientAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'measurement_unit']
    list_filter = ['name']


class IngredientInRecipeAdmin(admin.ModelAdmin):
    list_display = [f.name for f in IngredientInRecipe._meta.get_fields()]


class RecipeAdmin(admin.ModelAdmin):
    exclude = ['id', 'ingredients']
    list_filter = ['author', 'name']


class TagAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'color', 'slug']
    list_filter = ['name']


class RecipeSubModelAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'recipe']
    list_filter = ['user']


admin.site.register(Ingredient, IngredientAdmin)
admin.site.register(IngredientInRecipe, IngredientInRecipeAdmin)
admin.site.register(Recipe, RecipeAdmin)
admin.site.register(Tag, TagAdmin)
admin.site.register(RecipeFavorite, RecipeSubModelAdmin)
admin.site.register(RecipeInCart, RecipeSubModelAdmin)
