Router.configure  
  	layoutTemplate: 'layout'
  	loadingTemplate: 'loading'

Router.onBeforeAction 'loading' # show loading template while waiting for the action

Router.map -> 
	@route 'home', path:'/'