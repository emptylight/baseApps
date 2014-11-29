```
# class and constructor are not needed
baseObj =
  init: (obj) ->
    {@name, @age} = obj

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
