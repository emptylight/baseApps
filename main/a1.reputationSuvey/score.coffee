@Scores = new Mongo.Collection 'scores'
#  对于专家来讲,只需要看到医院名字,以及评分输入框,但对于数据库来讲,需要自动补齐相关的数据
Schemas.Scores = new SimpleSchema [
  Schemas.TimeHospitalDeptment
  {"姓名":
    type: String #Schemas.Specialists
    label: '专家名'
    max: 60
    autoform:
      options: ->
        _.map Specialists.find().fetch(), (specialist) ->
          #console.log specialist['专家名'] 看来查询没错,不知为何不行?
          label: specialist[ "姓名" ]
          value: specialist._id
  "评分":
    type: Number # 应从指标数据库取得定义的类型
    decimal: true
    label: '评分'
  }

  Schemas.CommitInfo
]

Scores.attachSchema Schemas.Scores


AdminConfig.collections.Scores = {
  label: 'A1.专科声誉'
  #icon: 'pencil'
  tableColumns: [
    {label: '医院', name:'医院'}
    {label: '专科名', name:'专科名', collection: 'Specialties'}
    {label: '专家名', name:'姓名', collection: 'Specialists'} #模仿 提交者但不行?
    {label: '评分',name:'评分'}
    {label:'提交者',name:'提交者', collection: 'Users'}
    {label:'已审核',name:'已审核'}
  ]
  auxCollections: ['Specialties', 'Specialists', 'Hospitals']
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
