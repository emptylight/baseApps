###
#
# 注意
# 變量皆無須導出至大環境中,故此,功能完全獨立,不影響其他部分.
# 此即如此佈置的好處.好處即形成獨立的部件.
#
###

WList = new Meteor.Collection 'WList'

admin = 'J.K'

approved = wlisted = (name) ->
  return false unless name?
  name is admin or WList.findOne(username:name)?




# --------------------------------
Meteor.methods

  'addUser':(username, newname)->
    if approved username
      WList.insert
        username: newname
        by: username
      #console.log "added user #{newname}"

  'removeUser':(username, thename)->
    if username is admin
      WList.remove
        username: thename


Meteor.users.helpers # using collection-helpers here. See home.jade for example
  wlisted: (username=@username)-> wlisted username


# ------------------------------
if Meteor.isServer

  Meteor.publish "wlist", (username) ->
    if approved username # full properties 
      WList.find {}
    else
      WList.find {}, fields:  # only some fields
        username: false
        # or: 
        # by: true 
        #Meteor.users.find().fetch()
  
  ###
  Meteor.publish "wlist", (username) ->
    if approved username # full properties 
      #WList.find {}
      Meteor.users.find {}
    else
      #WList.find {}, fields:  # only some fields
      Meteor.users.find {}, fields:  # only some fields
        username: false
        emails:true
        # or: 
        # by: true 
        #Meteor.users.find().fetch()
  ###




# -----------------------------------
if Meteor.isClient



  Tracker.autorun -> # it works already, without this line

    Meteor.subscribe "wlist", Meteor.user()?.username



  Template.wlist.helpers

    visible: -> Meteor.user()?.username in [admin] #this is not safe

    isAdmin: -> Meteor.user()?.username is admin #not safe



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
  #
  # template helper 寫在何處,主要考慮部件的獨立完整.
  # 以此爲例,如home這個template放在此處覺得不妥,則可以寫一個wlistForm template
  # Template.home.helpers
  Template.wlistTable.helpers
    #wlist: -> WList.find {}
    wlist: -> Meteor.users.find {}
  ###
  Template.aTable.helpers
    wlist: -> WList.find {}
  ###