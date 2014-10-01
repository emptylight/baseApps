@MainCollection = new Meteor.Collection 'mainCollection'

if Meteor.isClient
  Meteor.subscribe 'mainCollection'

if Meteor.isServer
	Meteor.publish 'mainCollection', -> MainCollection.find {} #currentTurn: @userId #find @userId is currentTurn user ids