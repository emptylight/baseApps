if Meteor.isClient
  UI.registerHelper 'AppName', -> 'thisAppName'
  UI.registerHelper 'wlisted', -> "#{Meteor.user()?.wlisted()}"
  #Template.splash.helpers
  #  AppName: -> 'AppName'
