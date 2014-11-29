# Some commonly used schemas 常用法类,
# 凡可用于各类应用的放在此处

Schemas.CommitInfo = new SimpleSchema
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
  "已审核":
    type: Boolean
    label: "已审核"
    optional: true
  "审核日期":
    type: Date
    label: '审核日期'
    optional: true
    autoValue: ->
      if @isInsert or @isUpdate
        return new Date()
  "审核者":
      type: String
      regEx: SimpleSchema.RegEx.Id
      optional: true
      autoValue: ->
        if @isInsert or @isUpdate
          return Meteor.userId()
      autoform:
        options: ->
          _.map Meteor.users.find().fetch(), (user)->
            label: user.emails[0].address
            value: user._id


Schemas.PostAddress = new SimpleSchema
  "省/直辖市":
    type: String
    label: '省/直辖市'
    max: 60
  "市":
    type: String
    label: '市'
    max: 10
  "县":
    type: String
    label: '县'
    max: 10
    optional: true
  "邮政地址":
    type: String
    label: '邮政地址'
    max: 100
  "邮政编码":
    type: Number
    label: '邮政编码'
    regEx: /^[0-9]{6}$/

Schemas.ElectronicInfo = new SimpleSchema
  "电子邮箱":
    type: String
    label: '电子邮箱'
    regEx: SimpleSchema.RegEx.Email
  "后备电子邮箱":
    type: String
    label: '后备电子邮箱'
    regEx: SimpleSchema.RegEx.Email
    optional:true
  "微信号":
    type: String
    label: '微信号'
    max: 38
  "单位电话":
    type: String
    label: '单位电话'
    max:19
    optional: true

Schemas.PersonalElectronicInfo = new SimpleSchema [
  Schemas.ElectronicInfo,
   {"移动电话":
    type: Number
    label: '移动电话'
    regEx: /^[0-9]{11}$/
  }
]

Schemas.PersonalContact = new SimpleSchema [
  {"姓名":
    type: String
    label: '姓名'
    max: 10
  }
  Schemas.PersonalElectronicInfo
  Schemas.PostAddress
  ]

Schemas.OrganizationContact = new SimpleSchema [Schemas.ElectronicInfo, Schemas.PostAddress]
