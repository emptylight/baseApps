```
@Reports = new Mongo.Collection 'reports'

Schemas.Reports = new SimpleSchema [
  {"年度":
    type: Number
    label: '年度'
  "月份":
    type: Number
    label: '月份'
  "医院":
    type: String
    label: '医院'
    max:30
  "专科名":
    type: String #Schemas.Specialties
    label: '专科名'
    max: 30
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty._id
  },
  Schemas.Indicators,
  {"三级指标":
    type: String #Schemas.Indicators
    label: '三级指标'
    max: 60
    autoform:
      options: ->
        _.map Indicators.find().fetch(), (indicator) ->
          #console.log indicator['三级指标'] 看来查询没错,不知为何不行?
          label: indicator[ "三级指标" ]
          value: indicator._id

  "指标值":
    type: Number # 应从指标数据库取得定义的类型
    decimal: true
    label: '指标值'
    optional: true
  "提交日期":
    type: Date
    label: '提交日期'
    autoValue: ->
      if this.isInsert
        return new Date()
  "提交者":
    type: String
    regEx: SimpleSchema.RegEx.Id
    autoValue: ->
      if this.isInsert
        return Meteor.userId()
    autoform:
      options: ->
        _.map Meteor.users.find().fetch(), (user)->
          label: user.emails[0].address
          value: user._id
  }
]
Reports.attachSchema Schemas.Reports


AdminConfig.collections.Reports = {
  label: 'G阶段报告'
  #icon: 'pencil'
  tableColumns: [
    {label: '医院', name:'医院'}
    {label: '专科名', name:'专科名', collection: 'Specialties'}
    {label: '三级指标', name:'三级指标', collection: 'Indicators'} #模仿 提交者但不行?
    {label: '指标值',name:'指标值'}
    {label:'提交者',name:'提交者', collection: 'Users'}

  ]
  auxCollections: ['Specialties', 'Indicators']
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
```
