@Specialists = new Mongo.Collection 'specialists'
#'专家库' Chinese is supported now
@SpecialistsApplications = new Mongo.Collection 'specialistsApplications'

# 注意中文 selector 名如果不加引号, deploy 会出错
Schemas.Specialists = new SimpleSchema
  "姓名":
    type: String
    label: '姓名'
    max: 60
  "专科名":
    type: String
    label: '评委专科名'
    max: 60
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty._id
  "所属学会":
    type: String
    label: '所属学会'
    max: 60
  "所在单位":
    type: String
    label: '所在单位'
    max: 60
  "省/直辖市":
    type: String
    label: '省/直辖市'
    max: 60
  "市":
    type: String
    label: '市'
    max: 10
  ### 这些放在 peopleContacts
  "手机":
    type: String
    label: '手机'
    max: 13
  "邮箱":
    type: String
    label: '邮箱'
    max: 60
  "联系地址":
    type: String
    label: '联系地址'
    max: 100
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

Specialists.attachSchema Schemas.Specialists



AdminConfig.collections.Specialists = {
  label: 'B3.专家资料'
  #icon: 'pencil'
  tableColumns: [
    {label: '评委专科名', name:'专科名', collection: 'Specialties'}
    {label: '所属学会', name:'所属学会'}
    {label: '所在单位', name:'所在单位'}
    {label: '姓名', name:'姓名'}
    {label: '手机', name:'手机'}
    {label: '邮箱', name:'邮箱'}
    {label: '联系地址', name:'联系地址'}
    # {label:'提交者',name:'提交者'}
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
