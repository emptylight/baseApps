# 注意中文 selectors 名如果不加引号, 目前版本 deploy 会出错
# 怎样在autoform 中加入一个 object,有待学习
# 此处须在 autoform 中加入工作单位 object
@PeopleContacts = new Mongo.Collection 'peopleContacts'
@PeopleContactsApplications = new Mongo.Collection 'peopleContactsApplications'
# 与 profile 合并或並入 profileSchema使用

Schemas.PeopleContacts = new SimpleSchema [
  Schemas.PersonalContact

  {"单位类型":
    type: String
    label: '单位类型'
    optional: true
   "工作单位":
    type: String
    label: '工作单位'
    max: 60
    optional:true
  }

  #Schemas.CommitInfo

]

PeopleContacts.attachSchema Schemas.PeopleContacts



AdminConfig.collections.PeopleContacts = {
  label: '个人信息'
  #icon: 'pencil'
  tableColumns: [
    {label: '單位', name: '工作单位'}
    {label: '单位类型', name:'单位类型'}
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
  #->
  Tracker.autorun -> # it works already, without this line
    Meteor.subscribe "peopleContacts"

  Template.peopleContacts.helpers
    peopleContacts: PeopleContacts.find {}

if Meteor.isServer
  #->
  Meteor.publish 'peopleContacts'
