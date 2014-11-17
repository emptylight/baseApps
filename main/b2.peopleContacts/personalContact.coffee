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
    autoform:
      options: ->
        _.map OrgTypes.find().fetch(), (obj)->
          label: obj['单位类型']
          value: obj._id #['单位类型']
  "工作单位":
    type: String
    label: '工作单位'
    max: 60
    optional:true
  ###
    autoform:
      options: ->
        dw = (@field "单位类型").value
        coll = null
        switch dw
          when '医院' then coll =  Hospitals
          when '学会' then coll =  Associations
          else return
        console.log this, coll
        _.map coll.find().fetch(), (org)->
          label: org['单位名称']
          value: org._id
  ###


  }

  Schemas.CommitInfo

]

PeopleContacts.attachSchema Schemas.PeopleContacts



AdminConfig.collections.PeopleContacts = {
  label: 'B2.个人信息'
  #icon: 'pencil'
  tableColumns: [
    {label: '姓名', name: '姓名'}
    {label: '单位类型', name:'单位类型', collection: 'OrgTypes'}
    {label: '移动电话', name:'移动电话'}
    {label: '电子邮箱', name:'电子邮箱'}
    {label: '邮政地址', name:'邮政地址'}
    {label:'提交者',name:'提交者',collection:'Users'}
  ]

  auxCollections: ['OrgTypes','Hospitals','Associations']
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
