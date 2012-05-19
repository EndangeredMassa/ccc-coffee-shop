{Commander} = require_root('app/commander')

describe Commander, ->
  beforeEach ->
    @commander = new Commander

  it 'processes message command', ->
    notified = false
    @commander.on 'message', (message) ->
      notified = message.text
    @commander.process('hey there tom')
    waitsFor -> notified == 'hey there tom'

  it 'processes a username command', ->
    notified = false
    @commander.on 'username', (oldUserName, newUserName) ->
      notified = newUserName
    @commander.process('/name Sean')
    waitsFor -> notified == 'Sean'

