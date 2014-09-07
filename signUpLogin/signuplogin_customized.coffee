if Meteor.isClient

	Template.signup.events
		'click button': (e, t) ->
			e.preventDefault()
			Accounts.createUser
				email: t.find('#su-email').value
				username: t.find('#su-username').value
				password: t.find('#su-password').value
			Session.set 'signup', false
		'click a': (e, t) ->
			e.preventDefault()
			Session.set 'signup', false	

	Template.signupLogin_customized.visable = ->
		Session.get 'signup'


	Template.login.events
		'click button': (e, t) ->
			e.preventDefault()
			Meteor.loginWithPassword t.find('#li-username').value, 
				t.find('#li-password').value
				(err)-> console.log err

		'click a': (e, t) ->
			e.preventDefault()
			Session.set 'signup', true 

	Template.logout.events
		'click button': (e,t) ->
			e.preventDefault()
			Meteor.logout()
