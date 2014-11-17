@DevicesReports = new Mongo.Collection 'devicesReports'

#列举所有病死率名
Schemas.DevicesReports = new SimpleSchema [
  Schemas.TimeHospitalDeptment
  {"彩色多普勒":
    type: Boolean
    label: '彩色多普勒'
    optional: true
  "64排CT":
    type: Boolean
    label: '64排CT'
    optional: true

  }
  Schemas.CommitInfo
]

DevicesReports.attachSchema Schemas.DevicesReports


AdminConfig.collections.DevicesReports = {
  label: 'A4.设备报表'
  #icon: 'pencil'
  tableColumns: [
    {label: '医院', name:'医院'}
    {label: '彩色多普勒',name:'彩色多普勒'}
    {label: '64排CT',name:'64排CT'}
    {label:'提交者',name:'提交者', collection: 'Users'}
    {label:'已审核',name:'已审核'}
  ]
  auxCollections: ['Hospitals', 'Specialties', 'Indicators']
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
