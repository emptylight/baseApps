# create schema base on database
# 动态的 Schema 用于从数据库取得字段名,然后组成一个定义,比如在 HQ-Share 项目中的指标体系
# 经过搜索没有找到现成的,自己试试做一个吧
schemaFromCollection = (schema, collection) ->
  for obj in collection
    schema[obj['信息项目']]
# 难度很大,无暇研究先行搁置
