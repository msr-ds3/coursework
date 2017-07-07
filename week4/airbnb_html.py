import requests
from   bs4 import BeautifulSoup
import re

class Listing():
    def __init__(self, listing_id):
        self.listing_id   = listing_id
        html              = get_listing_page(listing_id)
        self.listing_data = BeautifulSoup(html, 'html.parser')

    def get_description(self):
        return self.listing_data.find(id="details").text

    def get_cover_image_url(self):
        style = self.listing_data.find_all('div', class_="coverImage_75zala")[0]['style']
        url   = re.search(r"url\((.*)\)", style).group(1)
        return url

    def download_cover_image(self):
        url = self.get_cover_image_url()
        r   = requests.get(url)
        if r.status_code == 200:
            with open("listing_{}_cover.jpg".format(self.listing_id), 'wb') as f:
                f.write(r.content)


def get_listing_page(listing_id):
    r = requests.get('https://www.airbnb.com/rooms/{}'.format(listing_id))
    print(r.status_code)
    return(r.text)

def pretty_html(html):
    page = BeautifulSoup(html, 'html.parser')
    return page.prettify()

if __name__ == "__main__":
    listing_id = 6412281

    #  html = get_listing_page(listing_id)
    #  print(html)
    #  print(pretty_html(html))

    #  l = Listing(listing_id)
    #  print(l.get_description())
    #  print(l.download_cover_image())
