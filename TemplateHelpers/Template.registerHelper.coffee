if Meteor.isClient
  Template.registerHelper 'AppName', -> "#{moment().get('y')}"
  Template.registerHelper 'wlisted', -> "#{Meteor.user()?.wlisted()}"
  #Template.splash.helpers
  #  AppName: -> 'AppName'
