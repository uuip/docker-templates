# Generated by Django 4.2.9 on 2024-01-29 07:31

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="User",
            fields=[
                ("id", models.BigAutoField(primary_key=True, serialize=False)),
                ("name", models.TextField(blank=True, null=True, unique=True)),
                ("org", models.TextField(blank=True, null=True)),
                ("books", models.TextField(blank=True, null=True)),
                ("nickname", models.CharField(blank=True, null=True)),
            ],
            options={
                "db_table": "user",
            },
        ),
    ]
