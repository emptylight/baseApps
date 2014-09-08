if Meteor.isClient
  UI.registerHelper 'AppName', -> "#{moment().get('y')}"
  UI.registerHelper 'wlisted', -> "#{Meteor.user()?.wlisted()}"
  #Template.splash.helpers
  #  AppName: -> 'AppName'
