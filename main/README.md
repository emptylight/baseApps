# 此文件夹放置本应用特殊的东西.
  1. 大体分为应用的界面,以及相关的逻辑和数据库操作等等.
  1. 尝试将逻辑和数据库操作放在一个 coffee 文件内,而界面设计放在一个文件夹内.
  1. pprm 界面设计尽量分成小的片段,以便插拔

# 英文的使用参阅:
  1. http://health.usnews.com/health-news/best-hospitals/articles/2014/07/15/faq-how-we-ranked-the-best-hospitals-2014-15%20?page=3

# 使用以下的packages,请看各自网址上的说明文档
  1. https://github.com/aldeed/meteor-simple-schema
  1. https://github.com/aldeed/meteor-collection2
  1. https://github.com/aldeed/meteor-autoform/

# Schemas 是类似数据结构定义这样的意思,可以组合使用
  1. 通用於各种项目的常用的定义放在 lib/common1 的 coffee 文件中,请参阅
  1. 限于本项目同类应用的常用的定义放在 main/a.admin 的 coffee 文件中,请参阅
  1. 我做了几个例子,参见 main/score.coffee 可以仿照去提炼和改写 main 中其他的 coffee
