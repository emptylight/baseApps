@OrgTypes = new Mongo.Collection 'orgTypes'
#'专家库' Chinese is supported now
@OrgTypesApplications = new Mongo.Collection 'orgTypesApplications'

# 注意中文 selector 名如果不加引号, deploy 会出错
Schemas.OrgTypes = new SimpleSchema
  "单位类型":
    type: String
    label: '单位类型'
    max: 10
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

OrgTypes.attachSchema Schemas.OrgTypes



AdminConfig.collections.OrgTypes = {
  label: 'C2.单位类型'
  #icon: 'pencil'
  tableColumns: [
    {label: '单位类型', name:'单位类型'}
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
