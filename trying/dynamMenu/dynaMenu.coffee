if Meteor.isClient
  UI.body.helpers
   getTemplate: -> 'dynaMenu'

   getDataContext: ->
     title: 'My Title' 
