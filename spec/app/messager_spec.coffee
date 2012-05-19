{Messager} = require_root ('app/messager.coffee')

describe 'Messager', ->
  beforeEach ->
    @messager = new Messager

  it 'adds and retrieves messages', ->
    @messager.add('hey there')
    expect(@messager.getMessages()).toContain('hey there')

  it 'notifies listeners of new messages', ->
    notified = false
    @messager.on 'add', (eventMessage) ->
      notified = true
    @messager.add('hey there')
    waitsFor -> notified


