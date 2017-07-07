import requests
import json

def search():
    url = "https://api.streeteasy.com/nyc/api/v4/rentals/search/in_rect:40.787766,40.820511,-73.967066,-73.939600%7Cstatus:open%7Cprice:-3500%7Cbeds%3E=2?offset=0&interesting=false&order=updated_desc&limit=75&app_user=6980EE70-F9F1-43A4-9B57-AC97820DA9C8&key=987aa4e9eead4ecfa64d4cbdbf718067b6391def&app_name=com.StreetEasyInc.Streeteasy"
    data = {"login_token": "2454383|4c8300572c40e3ea"}
    r = requests.get(url, headers={
        'Host':             'api.streeteasy.com',
        'Content-Type':     'application/json',
        'Cookie':           '_ses=BAh7B0kiD3Nlc3Npb25faWQGOgZFVEkiJTg0YTM1ZTc1ZjU5YmNjODZkNDNhNTQzNDg0OTI4NTJlBjsAVEkiDHVzZXJfaWQGOwBGaQNvcyU%3D--9a5f6bb1a7d877a7e72ed6bd9e25e2127a0b830b',
        'Connection':       'keep-alive',
        'Accept':           '*/*',
        'User-Agent':       'StreetEasy/8.1.0 (iPhone; iOS 10.3.2; Scale/2.00)',
        'Accept-Language':  'en-US;q=1, fr-FR;q=0.9',
        'Content-Length':   '42',
        'Accept-Encoding':  'gzip, deflate',
    }, data=json.dumps(data))
    print(r)
    return r.json()

def pretty_json(obj):
    return json.dumps(obj, indent=4, sort_keys=True)

if __name__ == "__main__":
    data = search()
    print(pretty_json(data))
