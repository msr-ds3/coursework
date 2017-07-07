from selenium import webdriver
import time


browser = webdriver.Firefox()
browser.get('https://www.airbnb.com')

listing = browser.find_element_by_css_selector("div[id^='listing-']")
link    = listing.find_element_by_css_selector("a")
link.click()

#  print(link.get_attribute("href"))
#  link = link.get_attribute("href")
#  browser.get(link)
#  book_it_button = browser.find_element_by_css_selector("div[class=book-it__btn-width]") \
                        #  .find_element_by_css_selector("button").click()

