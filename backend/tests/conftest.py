import os
import sys

from django.utils.version import get_version

root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(root_dir)

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
root_dir_content = os.listdir(BASE_DIR)
PROJECT_DIR_NAME = 'backend'
PROJECT_NAME = 'foodgram'

if (
        PROJECT_NAME not in root_dir_content
        or not os.path.isdir(os.path.join(BASE_DIR, PROJECT_NAME))
):
    assert False, (
        f'В директории `{BASE_DIR}` не найдена папка '
        f'c проектом `{PROJECT_NAME}`. '
        f'Убедитесь, что у вас верная структура проекта.'
    )

MANAGE_PATH = BASE_DIR
project_dir_content = os.listdir(MANAGE_PATH)
FILENAME = 'manage.py'

if FILENAME not in project_dir_content:
    assert False, (
        f'В директории `{MANAGE_PATH}` не найден файл `{FILENAME}`. '
        f'Убедитесь, что у вас верная структура проекта.'
    )

assert get_version() == '3.2.9', 'Пожалуйста, используйте версию Django == 3.2.9'

pytest_plugins = [
    'tests.fixtures.fixture_user',
]
