from django.contrib.auth import get_user_model
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken


def create_users_api(admin_client):
    data = {
        'username': 'TestUser',
        'email': 'testuser@foodgram.fake'
    }
    admin_client.post('/api/users/', data=data)
    user = get_user_model().objects.get(username=data['username'])
    return user


def auth_client(user):
    refresh = RefreshToken.for_user(user)
    client = APIClient()
    client.credentials(
        HTTP_AUTHORIZATION=f'Token {refresh.access_token}'
    )
    return client


def create_tags(admin_client):
    result = []
    data = {
        'name': 'Breakfast',
        'color': '#f5d22e',
        'slug': 'breakfast'
    }
    admin_client.post('/api/categories/', data=data)
    result.append(data)
    data = {
        'name': 'Lunch',
        'color': '#ee11aa',
        'slug': 'lunch'
    }
    admin_client.post('/api/categories/', data=data)
    result.append(data)
    data = {
        'name': 'Dinner',
        'color': '#aa11ee',
        'slug': 'dinner'
    }
    admin_client.post('/api/categories/', data=data)
    result.append(data)
    return result


def create_ingredients(admin_client):
    result = []
    data = {
        'name': 'Egg',
        'measurement_unit': 'pc',
    }
    admin_client.post('/api/ingredients/', data=data)
    result.append(data)
    data = {
        'name': 'Milk',
        'measurement_unit': 'ml',
    }
    admin_client.post('/api/ingredients/', data=data)
    result.append(data)
    data = {
        'name': 'Flour',
        'measurement_unit': 'g',
    }
    admin_client.post('/api/ingredients/', data=data)
    result.append(data)
    data = {
        'name': 'Banana',
        'measurement_unit': 'pc',
    }
    admin_client.post('/api/ingredients/', data=data)
    result.append(data)
    data = {
        'name': 'Banana',
        'measurement_unit': 'g',
    }
    admin_client.post('/api/ingredients/', data=data)
    result.append(data)
    return result


def create_recipes(admin_client):
    tags = create_tags(admin_client)
    ingredients = create_ingredients(admin_client)
    result = []
    data = {
        'ingredients': [
            {"id": ingredients[0], "amount": 1},
            {"id": ingredients[2], "amount": 60},
            {"id": ingredients[3], "amount": 1}, 
        ],
        'tags': [tags[0]['slug'], tags[1]['slug'], ],
        'image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAgMAAABieywaAAAACVBMVEUAAAD///9fX1/S0ecCAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAACklEQVQImWNoAAAAggCByxOyYQAAAABJRU5ErkJggg==',
        'name': 'Banana pancakes',
        'text': 'test text for the first Recipe',
        'cooking_time': '30',
    }
    response = admin_client.post('/api/recipes/', data=data)
    data['id'] = response.json()['id']
    result.append(data)
    data = {
        'ingredients': [
            {"id": ingredients[1], "amount": 200},
            {"id": ingredients[3], "amount": 1}, 
        ],
        'tags': [tags[0]['slug'], tags[2]['slug'], ],
        'image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAgMAAABieywaAAAACVBMVEUAAAD///9fX1/S0ecCAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAACklEQVQImWNoAAAAggCByxOyYQAAAABJRU5ErkJggg==',
        'name': 'Banana milk',
        'text': 'test text for the secound Recipe',
        'cooking_time': '10',
    }
    response = admin_client.post('/api/recipes/', data=data)
    data['id'] = response.json()['id']
    result.append(data)
    return result, tags, ingredients
