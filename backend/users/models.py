from django.contrib.auth import get_user_model
from django.db import models

User = get_user_model()


class Follow(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='follower',
        verbose_name='follower'
    )
    author = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='following',
        verbose_name='following'
    )

    class Meta:
        ordering = ['-id']
        constraints = [
            models.UniqueConstraint(
                fields=['user', 'author'],
                name='unique User to Follow'
            )
        ]
        verbose_name = 'Follower'
        verbose_name_plural = 'Followers'

    def __str__(self):
        return f'User {self.user} is following {self.author}'

    def __repr__(self):
        return f'User {self.user} is following {self.author}'
