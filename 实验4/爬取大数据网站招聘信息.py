# -*- codeing = utf-8 -*-
import requests
import re
import json
import pymongo


class Search:
    def __init__(self, urls, head, db):
        self.urls = urls
        self.head = head
        self.db = db

    ## 使用json来提取提取字典
    @staticmethod
    def get_html_text(url, head):
        try:
            r = requests.get(url, headers=head)
            r.raise_for_status()  # 如果状态不是200 引发Httperror异常
            r.encoding = r.apparent_encoding
            return r.text
        except:
            return None

    ## 获取数据，并且使用MongoDB储存数据
    def get_information(self, html):
        try:
            r = re.findall("window.__SEARCH_RESULT__ = (.*?)</script>", html, re.S)
            ## 转换成字典形式
            r = "".join(r)
            infodict = json.loads(r)
            items = infodict["engine_jds"]
            for item in items:
                try:
                    item["attribute_text"] = "".join(item["attribute_text"])
                    information = {
                        "job_href": item["job_href"],
                        "job_name": item["job_name"],
                        "updatedate": item["updatedate"],
                        "company_name": item["company_name"],
                        "providesalary_text": item["providesalary_text"],
                        "companysize_text": item["companysize_text"],
                        "companyind_text": item["companyind_text"],
                        "jobwelf": item["jobwelf"],
                        "attribute_text": item["attribute_text"],
                    }
                    self.db["information"].insert_one(information)
                except:
                    print("爬取失败!")
        except:
            print("获取html失败!")
            return

    def search(self):
        for url in self.urls:
            print("正在爬取：" + url)
            html = self.get_html_tex(url, self.head)
            if html is None:
                continue
            self.get_information(html)


if __name__ == "__main__":
    page_num = 100
    urls = [
        "https://search.51job.com/list/000000,000000,0000,00,9,99,%25E5%25A4%25A7%25E6%2595%25B0%25E6%258D%25AE,2,{}.html?lang=c&postchannel=0000&workyear=99&cotype=99&degreefrom=99&jobterm=99&companysize=99&ord_field=0&dibiaoid=0&line=&welfare=".format(
            page
        )
        for page in range(1, page_num + 1)
    ]
    head = {
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language": "en",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/95.0.4638.69 Safari/537.36",
    }
    client = pymongo.MongoClient("localhost")
    db = client["job"]
    try:
        db.drop_collection("information")
        db.create_collection("information")
    except:
        db.create_collection("information")

    search = Search(urls=urls, head=head, db=db)
    search.search()
