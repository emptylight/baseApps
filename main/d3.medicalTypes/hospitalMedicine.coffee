@HospitalMedicines = new Mongo.Collection 'hospitalMedicines'
# 中医/西医/蒙医/中西医结合/民族医 等等

# 注意中文 selector 名如果不加引号, deploy 会出错
# 单位用户必然以联系人个人身份操作,故用户信息即此个人用户信息,如果换人则更新信息
Schemas.HospitalMedicines = new SimpleSchema
  "医学种类":
    type: String
    label: '医学种类'
    max: 15
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

HospitalMedicines.attachSchema Schemas.HospitalMedicines



AdminConfig.collections.HospitalMedicines = {
  label: 'D3.医学种类'
  #icon: 'pencil'
  tableColumns: [
    {label: '医学种类', name:'医学种类'}
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
