@UserTypes = new Mongo.Collection 'userTypes'
#'专家库' Chinese is supported now

# 注意中文 selector 名如果不加引号, deploy 会出错
# 单位用户必然以联系人个人身份操作,故用户信息即此个人用户信息,如果换人则更新信息
Schemas.UserTypes = new SimpleSchema [
  {"用户类型":
    type: String
    label: '用户类型'
    max: 60
  "用户权限":
    type: String
    label: '用户权限'
    max: 600
  }
  Schemas.CommitInfo
]

UserTypes.attachSchema Schemas.UserTypes



AdminConfig.collections.UserTypes = {
  label: 'C0.用户类型'
  #icon: 'pencil'
  tableColumns: [
    {label: '用户类型', name:'用户类型'}
    {label: '用户权限', name:'用户权限'}
    {label:'提交者',name:'提交者',collection:'Users'}
    {label:'已审核',name:'已审核'}

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
