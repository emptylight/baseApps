###
Some commonly used schemas 常用法类,
凡可用于本类应用的放在此处
###

Schemas.TimeHospitalDeptment = new SimpleSchema
  "年度":
    type: Number
    label: '年度'
  "月份":
    type: Number
    label: '月份'
  "医院":
    type: Schemas.Hospitals
    label: '医院'
    max:30
    autoform:
      options: ->
        _.map Hospitals.find().fetch(), (obj)->
          label: obj['单位名称']
          value: obj._id
  "专科":
    type: Schemas.Specialties #Object 则似乎不行,编辑保存不通过
    label: '专科名'
    max: 30
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty._id

###
例如:
###
###
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
###
# 例如医院等单位信息中有些部分是重复出现的可以提炼出来,等等
# 只要是重复出现的都可以提炼出来
