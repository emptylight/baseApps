if Meteor.isClient
	Meteor.subscribe 'users'

if Meteor.isServer
	Meteor.publish 'users', -> Meteor.users.find {}
# change server side code to change the access means security