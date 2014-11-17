###
AdminConfig.dashboard =
  homeUrl: '/dashboard'
  skin: 'black'

  widgets: [
              {
      template: 'adminCollectionWidget'
      data:
        collection: 'Posts'
        class: 'col-lg-3 col-xs-6'
    }
    {
      template: 'adminUserWidget'
      data:
        class: 'col-lg-3 col-xs-6'
    }
  ]
###
