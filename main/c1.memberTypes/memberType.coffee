@MemberTypes = new Mongo.Collection 'memberTypes'
#'专家库' Chinese is supported now

# 注意中文 selector 名如果不加引号, deploy 会出错
# 单位用户必然以联系人个人身份操作,故用户信息即此个人用户信息,如果换人则更新信息
Schemas.MemberTypes = new SimpleSchema
  "会员类型":
    type: String
    label: '会员类型'
    max: 60
  "年费标准":
    type: String
    label: '年费标准'
    max: 60
  "会员权益":
    type: String
    label: '会员权益'
    max: 600
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

MemberTypes.attachSchema Schemas.MemberTypes



AdminConfig.collections.MemberTypes = {
  label: 'C1.会员类型'
  #icon: 'pencil'
  tableColumns: [
    {label: '会员类型', name:'会员类型'}
    {label: '年费标准', name:'年费标准'}
    {label: '会员权益', name:'会员权益'}
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
