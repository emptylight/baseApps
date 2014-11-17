@OrgContacts = new Mongo.Collection 'orgContacts'
#'专家库' Chinese is supported now
@OrgContactsApplications = new Mongo.Collection 'orgContactsApplications'

# 注意中文 selector 名如果不加引号, deploy 会出错
Schemas.OrgContacts = new SimpleSchema
  "单位名称":
    type: String
    label: '单位名称'
    max: 60
  "单位类型":
    type: String
    label: '单位类型'
    autoform:
      options: ->
        _.map OrgTypes.find().fetch(), (orgType)->
          label: orgType['单位类型']
          value: orgType._id #['单位类型']
  "省/直辖市":
    type: String
    label: '省/直辖市'
    max: 60
  "市":
    type: String
    label: '市'
    max: 10
  "联系电话":
    type: String
    label: '联系电话'
    max: 13
  "电子邮箱":
    type: String
    label: '电子邮箱'
    max: 60
  "邮政地址":
    type: String
    label: '邮政地址'
    max: 100
  "邮政编码":
    type: String
    label: '邮政编码'
    max: 6
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

OrgContacts.attachSchema Schemas.OrgContacts



AdminConfig.collections.OrgContacts = {
  label: 'B4.单位信息'
  #icon: 'pencil'
  tableColumns: [
    {label: '单位名称', name: '单位名称'}
    {label: '单位类型', name:'单位类型'}#, collection: 'OrgTypes'}
    {label: '联系电话', name:'联系电话'}
    {label: '电子邮箱', name:'电子邮箱'}
    {label: '邮政地址', name:'邮政地址'}
    {label:'提交者',name:'提交者',collection:'Users'}
  ]

  auxCollections: ['OrgTypes']
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
