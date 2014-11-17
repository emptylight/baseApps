@Indicators = new Mongo.Collection 'indicators'

# 注意中文 selector 名如果不加引号, deploy 会出错
###
Schemas.Indicators = new SimpleSchema [
  "不适用专科名":
    type: [String] #Schemas.Specialties
    label: '不适用专科名'
    max: 60
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty['专科名'] #specialty._id
###
Schemas.Indicators = new SimpleSchema [

  {"一级指标":
    type: String
    label: '一级指标'
    max: 16
  "二级指标":
    type: [String]
    label: '二级指标'
    maxCount: 8
  "三级指标":
    type: [String]
    label: '三级指标'
    maxCount: 20
  }
  Schemas.CommitInfo

]

Indicators.attachSchema Schemas.Indicators


AdminConfig.collections.Indicators = {
  label: 'C5.指标体系'
  #icon: 'pencil'
  tableColumns: [
    {label: '一级指标', name:'一级指标'}
    {label: '二级指标', name:'二级指标'}
    {label: '三级指标', name:'三级指标'}
    {label:'提交者',name:'提交者',collection:'Users'}

  ]
  auxCollections: ['Specialties']
  ###
  templates:
    new:
      name: 'postWYSIGEditor'
      data:
        post: Session.get 'admin_doc'
    edit:
      name: 'postWYSIGEditor'
      data:
        post: Session.get 'admin_doc'
  ###
}


if Meteor.isClient
  ->

if Meteor.isServer
  ->
