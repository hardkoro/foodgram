from django.contrib import admin

from .models import Follow


class FollowAdmin(admin.ModelAdmin):
    list_display = ['pk', 'user', 'author']
    empty_value_display = '-empty-'


admin.site.register(Follow, FollowAdmin)
