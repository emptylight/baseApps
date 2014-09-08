WList = new Meteor.Collection 'WList'

jk = 'J.K'

approved= wlisted = (name) ->
  return false unless name?
  name is jk or WList.findOne(username:name)?




# --------------------------------
Meteor.methods

  'addUser':(username, newname)->
    if approved username
      WList.insert 
        username: newname 
        by: username
      #console.log "added user #{newname}"

  'removeUser':(username, thename)->
    if username is jk
      WList.remove 
        username: thename 
  

Meteor.users.helpers # see home.jade for example
  wlisted: -> wlisted @username  


# ------------------------------
if Meteor.isServer
  
  Meteor.publish "wlist", (username) ->
    if approved username
      WList.find {} #Meteor.users.find().fetch()





# -----------------------------------
if Meteor.isClient
  
  

  Tracker.autorun -> # it works already, without this line
  
    Meteor.subscribe "wlist", Meteor.user()?.username

  
  
  Template.wlist.helpers
    
    visible: -> Meteor.user()?.username in [jk] #this is not safe

    isAdmin: -> Meteor.user()?.username is jk #not safe

  
  
  Template.wlist.events
  
    'click #addUser': (e,t) ->
      e.preventDefault()
      unless (username = $('#username').val()?.trim())?
        return
      else  
        Meteor.call "addUser", Meteor.user().username, username
        $('#username').val('').select().focus()
        #console.log this, username
  
    'click #removeUser': (e,t) ->
      e.preventDefault()
      unless (username = $('#username').val()?.trim())?
        return
      else  
        Meteor.call "removeUser", Meteor.user().username, username
        $('#username').val('').select().focus()
        
        #console.log this, username
  
  Template.home.helpers
    wlist: -> WList.find {}