from rest_framework.permissions import SAFE_METHODS, BasePermission


class IsAdminOrReadOnly(BasePermission):
    """Edit is allowed for admin users only."""

    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
        if request.user.is_anonymous:
            return False
        return request.user.is_admin | request.user.is_superuser


class IsAdminOrAuthorOrReadOnly(BasePermission):
    """Edit is allowed for admin or author users only."""

    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
        return request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        if request.method in SAFE_METHODS:
            return True
        if request.user.is_anonymous:
            return False
        return (request.user == obj.author or request.user.is_admin)
