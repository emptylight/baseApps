if Meteor.isClient
	Meteor.subscribe 'mainCollection'
	Meteor.subscribe 'users'

if Meteor.isServer
	Meteor.publish 'mainCollection', -> MainCollection.find {} #currentTurn: @userId #find @userId is currentTurn user ids
	Meteor.publish 'users', -> Meteor.users.find {}
# change server side code to change the access means security