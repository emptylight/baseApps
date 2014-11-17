@Associations = new Mongo.Collection 'associations'
# 单位介绍可放在此处,而联络方式则统一放在 OrgContacts 里面

# 注意中文 selector 名如果不加引号, deploy 会出错
Schemas.Associations = new SimpleSchema
  "单位名称":
    type: String
    label: '单位名称'
    max: 60
    autoform:
      options: ->
        _.map OrgContacts.find().fetch(), (orgContact)->
          label: orgContact['单位名称']
          value: orgContact._id
  "专科名":
    type: String #Schemas.Specialties
    label: '专科名'
    max: 60
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty._id
  "中华":
    type: Boolean
  "简介":
    type: String
    label: '简介'
    max: 600
    optional: true
  "市":
    type: String
    label: '市'
    max: 10
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

Associations.attachSchema Schemas.Associations



AdminConfig.collections.Associations = {
  label: 'B7.学会资料'
  #icon: 'pencil'
  tableColumns: [
    {label: '专科名', name:'专科名', collection: 'Specialties'}
    {label: '中华', name:'中华'}
    {label: '单位名称', name:'单位名称', collection: 'OrgContacts'}
    {label:'简介',name:'简介'}
    {label:'提交者',name:'提交者',collection:'Users'}

  ]

  auxCollections: ['Specialties', 'OrgContacts']
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
