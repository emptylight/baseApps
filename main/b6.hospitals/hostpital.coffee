@Hospitals = new Mongo.Collection 'hospitals'
#'专家库' Chinese is supported now

# 注意中文 selector 名如果不加引号, deploy 会出错
Schemas.Hospitals = new SimpleSchema
  "单位名称":
    type: String#Schemas.OrgContacts
    label: '单位名称'
    autoform:
      options: ->
        _.map OrgContacts.find().fetch(), (obj)->
          label: obj['单位名称']
          value: obj._id

  "省/直辖市":
    type: String
    label: '省/直辖市'
    max: 60
  "市":
    type: String
    label: '市'
    max: 10
  "中西医分类":
    type: String
    label: '中西医分类'
    autoform:
      options: ->
        _.map HospitalMedicines.find().fetch(), (obj)->
          label: obj['医学种类']
          value: obj._id

  "评审等级":
    type: String
    label: '评审等级'
    autoform:
      options: ->
        _.map HospitalClasses.find().fetch(), (obj)->
          label: obj['评审等级']
          value: obj._id

  "教学医院":
    type: Boolean
    label: "教学医院"
  "所有制":
    type: String
    label: "所有制"
    max:20
    autoform:
      options: ->
        _.map HospitalOwners.find().fetch(), (obj)->
          label: obj['所有制']
          value: obj._id
  "行政区划":
    type: String
    label: "行政区划"
    autoform:
      options: ->
        _.map HospitalZones.find().fetch(), (obj)->
          label: obj['行政区划']
          value: obj._id
  "院长姓名":
    type: String
    label: '院长姓名'
    max: 10
  "院长手机":
    type: String
    label: '院长手机'
    max: 13
  "院长邮箱":
    type: String
    label: '院长邮箱'
    max: 60
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

Hospitals.attachSchema Schemas.Hospitals



AdminConfig.collections.Hospitals = {
  label: 'B6.医院资料'
  #icon: 'pencil'
  tableColumns: [
    {label: '单位名称', name:'单位名称', collection: 'OrgContacts'}
    # {label:'提交者',name:'提交者'}
    {label: '省/直辖市', name:'省/直辖市'}
    {label: '市', name:'市'}
    {label: '中西医分类', name:'中西医分类'}
    {label: '级别', name:'级别'}
    {label:'提交者',name:'提交者',collection:'Users'}

  ]

  auxCollections: [
    "HospitalMedicines"
    "HospitalClasses"
    'HospitalOwners'
    'HospitalZones'
    'OrgContacts'
    ]
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
