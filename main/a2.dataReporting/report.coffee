@IndicatorReports = new Mongo.Collection 'indicatorReports'

#列举所有病死率名
Schemas.IndicatorReports = new SimpleSchema [
  Schemas.TimeHospitalDeptment
  {"病死率":
    type: Number #Schemas.Indicators
    decimal: true #可以小数
    label: '病死率'
    min: 0

  "是否如何":
    type: Boolean
    label: '是否如何'
    optional: true
  }
  Schemas.CommitInfo
]

IndicatorReports.attachSchema Schemas.IndicatorReports


AdminConfig.collections.IndicatorReports = {
  label: 'A2.指标报表'
  #icon: 'pencil'
  tableColumns: [
    {label: '医院', name:'医院'}
    {label: '专科名', name:'专科名', collection: 'Specialties'}
    {label: '病死率', name:'病死率', collection: 'Indicators'} #模仿 提交者但不行?
    {label: '是否如何',name:'是否如何'}
    {label:'提交者',name:'提交者', collection: 'Users'}
    {label:'已审核',name:'已审核'}
  ]
  auxCollections: ['Hospitals','Specialties', 'Indicators']
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
