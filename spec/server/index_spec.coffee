zombie = require('zombie')

# move to helpers file; separate spec_helper?
jasmine.getEnv().defaultTimeoutInterval = 1000

visitLocalhost = (browser, callback) ->
  browser.visit 'http://localhost:1337/', (error, browser) ->
    callback(browser)

sendMessage = (browser, message, callback) ->
  browser.fill('#command', 'some text')
  command = browser.query('#command')
  browser.fire 'keyup', command, {keyCode:13}, ->
    callback(command)


# actual tests

describe 'One User', ->
  beforeEach ->
    @browser = new zombie.Browser

  it 'sends a message', ->
    command = null
    visitLocalhost @browser, (browser) ->
      sendMessage browser, 'some text', (cmd) ->
        command = cmd

    waitsFor -> command?
    runs ->
      expect(command.value).toBe('')

describe 'Multiple Users', ->
  beforeEach ->
    @browser1 = new zombie.Browser
    @browser2 = new zombie.Browser

  xit 'retrieves history', ->
    done = false
    visitLocalhost @browser1, (browser) ->
      sendMessage browser, 'message 1', (cmd) ->
        done = true
    waitsFor -> done
    
    messages = null
    runs ->
      visitLocalhost @browser2, (browser) ->
        messages = browser.queryAll('#messages tr')
        p messages
    waitsFor ->
      messages?

    runs ->
      expect(messages.length).toBe(1)


  it 'shows new users joining'
  it 'includes plugin: Moody'

