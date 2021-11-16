import argparse
import json

from django.core.management.base import BaseCommand, CommandError

from api.models import Ingredient


class Command(BaseCommand):
    help = 'Populates DB with ingredients data from specified JSON file'

    def add_arguments(self, parser):
        parser.add_argument('--file', type=argparse.FileType('r'))

    def add_ingredients(self, data):
        [
            Ingredient.objects.create(
                name=row.get('name'),
                measurement_unit=row.get('measurement_unit')
            ) for row in data
        ]

    def handle(self, *args, **options):
        for data in options['file']:
            try:
                self.add_ingredients(json.loads(data))
            except Exception as e:
                raise CommandError(f'Population failed: {str(e)[:100]}')

        self.stdout.write(
            self.style.SUCCESS('Ingredients are successfully populated')
        )
