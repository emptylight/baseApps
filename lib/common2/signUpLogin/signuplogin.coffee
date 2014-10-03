# both client and server
Accounts.config
  sendVerificationEmail: true

# server only
if Meteor.isServer
  ->
  
# client only
if Meteor.isClient

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_AND_EMAIL'