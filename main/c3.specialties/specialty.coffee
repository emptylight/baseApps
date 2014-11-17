@Specialties = new Mongo.Collection 'specialties'
#'专家库' Chinese is supported now

# 注意中文 selector 名如果不加引号, deploy 会出错
Schemas.Specialties = new SimpleSchema
  "专科名":
    type: String
    label: '专科名'
    max: 60
  "提交日期":
    type: Date
    label: '提交日期'
    autoValue: ->
      if @isInsert
        return new Date()
  "提交者":
    type: String
    regEx: SimpleSchema.RegEx.Id
    autoValue: ->
      if @isInsert
        return Meteor.userId()
    autoform:
      options: ->
        _.map Meteor.users.find().fetch(), (user)->
          label: user.emails[0].address
          value: user._id

Specialties.attachSchema Schemas.Specialties


AdminConfig.collections.Specialties = {
  label: 'C3.专科范围'
  #icon: 'pencil'
  tableColumns: [
    {label: '专科名', name:'专科名'}
    {label: '提交日期', name:'提交日期'}
    # {label:'提交者',name:'提交者'}
    {label:'提交者',name:'提交者',collection:'Users'}

  ]
  ###
  auxCollections: ['Attachments']
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

### 用了 autoform 不需要 publish/subscribe ? 测试结果可以
if Meteor.isClient
  Tracker.autorun -> # it works already, without this line

    Meteor.subscribe "specialties", Meteor.user()?


if Meteor.isServer
  Meteor.publish 'specialties', (user)->
    if user.isAdmin
      Specialties.find {}
    else
      []
###
