Schemas.WList = new SimpleSchema
  username:
    type: String
    label: '用戶名'
    max: 50
  "添加人":
    type: String
    label: '添加人'
    max: 50

WList.attachSchema Schemas.WList

AdminConfig.collections.WList = {
  label: 'WhiteList'
  #icon: 'pencil'
  tableColumns: [
    {label: '用户名', name:'username'}
    {label: '提交日期', name:'提交日期'}
    # {label:'提交者',name:'提交者'}
    {label:'添加人',name:'添加人',collection:'Users'}

  ]
  #auxCollections: ['Attachments']

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
