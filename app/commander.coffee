{EventEmitter} = require('events')

class Commander extends EventEmitter
  @toString: -> 'Commander'

  process: (input, user) ->
    if input[0] == '/'
      @slashCommand(input, user)
    else
      @message(input, user)

  message: (message, user) ->
    @emit 'message',
      user: user
      text: message

  slashCommand: (input, user) ->
    input = input.substring(1)
    parts = input.split(' ')
    command = parts.splice(0, 1)
    args = parts
    args.unshift(user)

    commandName = command + 'Command'
    commandFunc = this[commandName]
    if commandFunc?
      commandFunc.apply(this, args)

  nameCommand: (oldUserName, newUserName) ->
    @emit('username', oldUserName, newUserName)


exports.Commander = Commander
