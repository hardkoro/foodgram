import json

from django.core.management.base import BaseCommand, CommandError

from api.models import Ingredient

FILE_NAME = '../data/ingredients.json'


class Command(BaseCommand):
    help = 'Populates DB with ingredients data from JSON file'

    def add_ingredients(self, data):
        [
            Ingredient.objects.create(
                name=row.get('name'),
                measurement_unit=row.get('measurement_unit')
            ) for row in data
        ]

    def handle(self, *args, **options):
        with open(FILE_NAME, 'r', encoding='utf-8') as file:
            try:
                self.add_ingredients(json.load(file))
            except Exception as e:
                raise CommandError(f'Population failed: {str(e)[:100]}')

        self.stdout.write(
            self.style.SUCCESS('Ingredients are successfully populated')
        )
