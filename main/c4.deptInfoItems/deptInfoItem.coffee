@DeptInfoItems = new Mongo.Collection 'deptInfoItems'

# 注意中文 selector 名如果不加引号, deploy 会出错
Schemas.DeptInfoItems = new SimpleSchema
  ###
  "专科名":
    type: String #Schemas.Specialties
    label: '专科名'
    max: 60
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty._id
  ###
  "信息项目":
    type: String
    label: '信息项目'
    max: 16
  "字段类型":
    type: String
    label: '字段类型'
    max: 16
  "String限长":
    type: Number
    label: 'String限长'
    optional: true
  "是否可选":
    type: Boolean
    label: '是否可选'
###
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
###

DeptInfoItems.attachSchema Schemas.DeptInfoItems


AdminConfig.collections.DeptInfoItems = {
  label: 'C4.基本信息项目'
  #icon: 'pencil'
  tableColumns: [
    # {label: '专科名', name:'专科名', collection: 'Specialties'}
    {label: '信息项目', name:'信息项目'}
    {label: '字段类型', name:'字段类型'}
    {label: '是否可选', name:'是否可选'}
    # {label:'提交者',name:'提交者'}
    # {label:'提交者',name:'提交者',collection:'Users'}

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
