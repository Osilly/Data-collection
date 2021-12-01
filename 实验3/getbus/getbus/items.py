# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class GetbusItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    lineName = scrapy.Field()
    time = scrapy.Field()
    price = scrapy.Field()
    campony = scrapy.Field()
    upline = scrapy.Field()
    downline = scrapy.Field()
