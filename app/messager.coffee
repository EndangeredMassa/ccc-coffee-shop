{EventEmitter} = require('events')

class Messager extends EventEmitter
  constructor: ->
    @messages = []

  @toString: -> 'Messager'

  add: (message) ->
    @messages.push(message)
    @emit('add', message)

  getMessages: ->
    @messages

exports.Messager = Messager
