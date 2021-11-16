from django.contrib import admin

from .models import User, Follow


class UserAdmin(admin.ModelAdmin):
    list_display = ['pk', 'email', 'username', 'first_name', 'last_name']
    search_fields = ['email', 'username']

class FollowAdmin(admin.ModelAdmin):
    list_display = ['pk', 'user', 'author']
    empty_value_display = '-empty-'


admin.site.register(User, UserAdmin)
admin.site.register(Follow, FollowAdmin)
