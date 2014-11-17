@Members = new Mongo.Collection 'members'
#'专家库' Chinese is supported now
@MembersApplications = new Mongo.Collection 'membersApplications'

# 注意中文 selector 名如果不加引号, deploy 会出错
# 单位用户必然以联系人个人身份操作,故用户信息即此个人用户信息,如果换人则更新信息
Schemas.Members = new SimpleSchema
  "用户名":
    type: String
    label: '联系人'
    max: 60
    autoValue: ->
      if this.isInsert
        return Meteor.userId()
    autoform:
      options: ->
        _.map Meteor.users.find().fetch(), (user)->
          label: user.emails[0].address
          value: user._id
  "会员名":
    type: String
    label: '会员名'
    max: 60
  "会员类型":
    type: String
    label: '会员类型'
    max: 60
    autoform:
      options: ->
        _.map MemberTypes.find().fetch(), (memberType)->
          label: memberType['会员类型']
          value: memberType._id
  "单位名称":
    type: String
    label: '单位名称'
    max: 60
  "省/直辖市":
    type: String
    label: '省/直辖市'
    max: 60
  "市":
    type: String
    label: '市'
    max: 10
  "入会时间":
    type: Date
    label: '入会时间'
    max: 10
  "会员结束时间":
    type: Date
    label: '会员结束时间'
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

Members.attachSchema Schemas.Members



AdminConfig.collections.Members = {
  label: 'B5.会员资料'
  #icon: 'pencil'
  tableColumns: [
    {label: '会员类型', name:'会员类型', collection: 'MemberTypes'}
    {label: '单位名称', name:'单位名称'}
    {label: '会员名', name:'会员名'}
    {label: '入会时间', name:'入会时间'}
    {label: '会员结束时间', name:'会员结束时间'}
    # {label:'提交者',name:'提交者'}
    {label:'联系人',name:'用户名',collection:'Users'}

  ]

  auxCollections: ['MemberTypes']
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
