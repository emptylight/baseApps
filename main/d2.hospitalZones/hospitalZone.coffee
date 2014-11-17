@HospitalZones = new Mongo.Collection 'hospitalZones'
#'专家库' Chinese is supported now

# 注意中文 selector 名如果不加引号, deploy 会出错
# 单位用户必然以联系人个人身份操作,故用户信息即此个人用户信息,如果换人则更新信息
Schemas.HospitalZones = new SimpleSchema
  "行政区划":
    type: String
    label: '行政区划'
    max: 15
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

HospitalZones.attachSchema Schemas.HospitalZones



AdminConfig.collections.HospitalZones = {
  label: 'D2.行政区划'
  #icon: 'pencil'
  tableColumns: [
    {label: '行政区划', name:'行政区划'}
    {label:'提交者',name:'提交者',collection:'Users'}

  ]

  auxCollections: []
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
