@DepartmentInfo = new Mongo.Collection 'departmentInfo'
# 需要补齐全部基本资料.格式如 床位数
Schemas.DepartmentInfo = new SimpleSchema [
  Schemas.TimeHospitalDeptment
  {"床位数":
    type: Number # 可以是 Number/String/Boolean/Date/Object 等
    label: '床位数'
    min: 0
  "护士数":
    type: Number # 应从指标数据库取得定义的类型
    decimal: true
    label: '护士数'
  }

  Schemas.CommitInfo
]

DepartmentInfo.attachSchema Schemas.DepartmentInfo


AdminConfig.collections.DepartmentInfo = {
  label: 'A3.基本信息'
  #icon: 'pencil'
  tableColumns: [
    {label: '医院', name:'医院'}
    {label: '专科名', name:'专科名', collection: 'Specialties'}
    {label: '床位数', name:'床位数'} #模仿 提交者但不行?
    {label: '护士数',name:'护士数'}
    {label:'提交者',name:'提交者', collection: 'Users'}
    {label:'已审核',name:'已审核'}
  ]
  auxCollections: ['Hospitals','Specialties']
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
