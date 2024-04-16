from django.db import models


class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.TextField(unique=True, blank=True, null=True)
    org = models.TextField(blank=True, null=True)
    books = models.TextField(blank=True, null=True)  # This field type is a guess.
    nickname = models.CharField(blank=True, null=True)

    class Meta:
        db_table = "user"
