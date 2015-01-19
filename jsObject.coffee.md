```
# class and constructor are not needed, while super is not necessary and not supported
# this is read from an article which I've forgotten it's url

### translated from JavaScript
baseObj =
  init: (obj) ->
    {@name, @age} = obj

  identify: ->
    "I am #{@name}"
###
# In CoffeeScript it could be
baseObj =
  init: (@name, @age) ->
    #{@name, @age} = obj

  identify: ->
    "I am #{@name}"

newObj = Object.create baseObj

newObj.speak = ->
  console.log "hello, #{@identify()}."

no1 = Object.create newObj
no1.init
  name: 'no1'
  age: 1

no2 = Object.create newObj
no2.init
  name: 'no2'
  age: 2

no2.speak null
```
