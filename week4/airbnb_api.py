import requests
import json

def get_calendar_clean(listing_id):
    url = "https://www.airbnb.com/api/v2/calendar_months"
    params = {
        'key':        'd306zoyjsyarp7ifhu67rjxn52tv0t20',
        'currency':   'USD',
        'locale':     'en',
        'listing_id': listing_id,
        'month':      '7',
        'year':       '2017',
        'count':      '3',
        '_format':    'with_conditions',
    }
    r = requests.get(url, params=params)
    return r.json()

def get_calendar(listing_id):
    url = "https://www.airbnb.com/api/v2/calendar_months?key=d306zoyjsyarp7ifhu67rjxn52tv0t20&currency=USD&locale=en&listing_id={}&month=7&year=2017&count=3&_format=with_conditions"
    r = requests.get(url.format(listing_id))
    return r.json()

def pretty_json(obj):
    return json.dumps(obj, indent=4, sort_keys=True)

if __name__ == "__main__":
    listing_id = 6412281

    data = get_calendar(listing_id)
    #  print(pretty_json(data))
    day = data['calendar_months'][0]['days'][0]
    print(pretty_json(day))
