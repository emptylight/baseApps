@DeviceSheet = new Mongo.Collection 'deviceSheet'

# 注意中文 selector 名如果不加引号, deploy 会出错
###
Schemas.DeviceSheet = new SimpleSchema [
  "专科名":
    type: [String] #Schemas.Specialties
    label: '专科名'
    max: 60
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty['专科名'] #specialty._id
###
Schemas.DeviceSheet = new SimpleSchema [
  {"专科名":
    type: String #Schemas.Specialties
    label: '专科名'
    max: 60
    autoform:
      options: ->
        _.map Specialties.find().fetch(), (specialty)->
          label: specialty['专科名']
          value: specialty['专科名'] #specialty._id

  "设备名":
    type: [String]
    label: '设备名'
    maxCount: 26
  }
  Schemas.CommitInfo

]

DeviceSheet.attachSchema Schemas.DeviceSheet


AdminConfig.collections.DeviceSheet = {
  label: 'C6.设备配置'
  #icon: 'pencil'
  tableColumns: [
    {label: '专科名', name:'专科名', collection: 'Specialties'}
    {label: '设备名', name:'设备名'}
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
