from django.contrib import admin

from .models import Ingredient, IngredientInRecipe, Recipe, Tag, User


class UserAdmin(admin.ModelAdmin):
    list_display = ['id', 'username', 'first_name', 'last_name', 'email']
    list_filter = ['email', 'username']
    empty_value_display = '-empty-'


class IngredientAdmin(admin.ModelAdmin):
    list_display = ['name', 'measurement_unit']
    list_filter = ['name']
    empty_value_display = '-empty-'


class IngredientInRecipeAdmin(admin.ModelAdmin):
    list_display = [f.name for f in IngredientInRecipe._meta.get_fields()]
    empty_value_display = '-empty-'


class RecipeAdmin(admin.ModelAdmin):
    exclude = ['ingredients']
    list_filter = ['author', 'name']
    empty_value_display = '-empty-'


class TagAdmin(admin.ModelAdmin):
    list_display = [field.name for field in Tag._meta.get_fields()]
    list_filter = ['name']
    empty_value_display = '-empty-'


admin.site.register(User, UserAdmin)
admin.site.register(Ingredient, IngredientAdmin)
admin.site.register(IngredientInRecipe, IngredientInRecipeAdmin)
admin.site.register(Recipe, RecipeAdmin)
admin.site.register(Tag, TagAdmin)
