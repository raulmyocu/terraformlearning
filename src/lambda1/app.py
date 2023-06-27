import json

import requests

def handler(event, context):
    pokemon_name = json.loads(event.body)["pokemon_name"]
    response = requests.request("GET", url=f"https://pokeapi.co/api/v2/pokemon/{pokemon_name}")
    order = response.json()['order']
    return {
        "pokemon_name": pokemon_name
        "order": order
    }
