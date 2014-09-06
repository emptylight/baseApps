if Meteor.isClient # use coffee to create template and helpers
    Meteor.startUp ->
      # create a new DynamicTemplate instance and optionally set the initial template and
      dyna: -> new Iron.DynamicTemplate {}

      #render the component and inssert it into the dom defaulting to document.body
      dyna.insert 
        el: '#optional-container'
      
      dyna.template 'MyDynaTemplate'
      
      dyna.data 
        title: 'My Title'
 
      dyna.clear()
          title: 'My Title' 
