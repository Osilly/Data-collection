# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from . import settings
import pymysql


class GetbusPipeline:
    def __init__(self):
        self.host = settings.DB_HOST
        self.user = settings.DB_USER
        self.pwd = settings.DB_PWD
        self.db = settings.DB
        self.charset = settings.DB_CHARSET
        self.connect()

    def connect(self):
        # 连接数据库，创建一个数据库对象
        self.conn = pymysql.connect(host=self.host,
                                    user=self.user,
                                    password=self.pwd,
                                    db=self.db,
                                    charset=self.charset
                                    )
        # 开启游标功能，创建游标对象
        self.cursor = self.conn.cursor()

    def process_item(self, item, spider):
        sql = 'insert into information(lineName,time,price,campony,upline,downline) values ("%s","%s","%s","%s","%s","%s")' % (
            item['lineName'], item['time'], item['price'], item['campony'], item['upline'], item['downline'])
        # 执行SQL语句
        self.cursor.execute(sql)  # 使用execute方法执行SQL语句
        self.conn.commit()  # 提交到数据库执行
        return item

    # 用于关闭数据库的连接
    def close_spiders(self):
        self.conn.close()
        self.cursor.close()
