import scrapy
from ..items import GetbusItem
from urllib.parse import urljoin


class BeijingBusSpider(scrapy.Spider):
    name = 'beijing_bus'
    allowed_domains = ['beijing.8684.cn']
    start_url = 'http://beijing.8684.cn'

    # 开始爬取
    def start_requests(self):
        yield scrapy.FormRequest(url=self.start_url, callback=self.get_second_page)

    # 二级页面
    def get_second_page(self, response):
        ls1 = response.xpath(
            "//div[@class='bus-layer depth w120']//div[@class='pl10'][1]//div[@class='list']//a//@href").extract()
        ls2 = response.xpath(
            "//div[@class='bus-layer depth w120']//div[@class='pl10'][2]//div[@class='list']//a//@href").extract()
        for next_url in ls1:
            url = urljoin(self.start_url, next_url)
            yield scrapy.Request(url=url, callback=self.get_third_page)
        for next_url in ls2:
            url = urljoin(self.start_url, next_url)
            yield scrapy.FormRequest(url=url, callback=self.get_third_page)

    # 三级页面
    def get_third_page(self, response):
        ls = response.xpath("//div[@class='list clearfix']/a//@href").extract()
        for next_url in ls:
            url = self.start_url + next_url
            yield scrapy.Request(url=url, callback=self.get_detail)

    # 获取三级页面详细信息
    def get_detail(self, response):
        try:
            lineName = response.xpath("//h1[1]//text()").extract_first()
        except:
            lineName = ''
        try:
            time = response.xpath("//ul[@class='bus-desc']//li[1]//text()").extract_first()
        except:
            time = ''
        try:
            price = response.xpath("//ul[@class='bus-desc']//li[2]//text()").extract_first()
        except:
            price = ''
        try:
            campony = response.xpath("//ul[@class='bus-desc']//li[3]//a//text()").extract_first()
        except:
            campony = ''

        try:
            lines = response.xpath("//div[@class='bus-lzlist mb15']")
            # 获取上行线路
            ls = lines[0].xpath(".//text()").extract()
            str = '-'.join(ls)
            upline = str

            # 获取下行线路
            if len(lines) > 1:
                ls = lines[1].xpath(".//text()").extract()
                str = '-'.join(ls)
                downline = str
        except:
            upline = ''
            downline = ''

        # 格式化数据
        bus_item = GetbusItem()
        for field in bus_item.fields:
            bus_item[field] = eval(field)
        yield bus_item

    def parse(self, response):
        pass
