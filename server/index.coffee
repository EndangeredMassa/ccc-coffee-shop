#server stuff
express = require('express')
{configure} = require('./config')
app = module.exports = express.createServer()
io = require('socket.io').listen(app, { log: false })
configure(express, app)

#app stuff
userList  = new (require('../app/user_list').UserList)
commander = new (require('../app/commander').Commander)
messager  = new (require('../app/messager').Messager)

broadcast = (message) ->
  io.sockets.emit 'add_message', message

# plugins!
{Moody} = require('../app/plugins/moody')
moody = new Moody (broadcast)
commander.on 'message', (message) ->
  moody.feel(message.text)


# wiring app parts
commander.on 'message', (message) ->
  messager.add(message)


# wiring server to app
guestCount = 1

io.sockets.on 'connection', (socket) ->
  userName = "guest_#{guestCount++}"
  userList.addUser(userName)


  # server to client
  socket.emit 'init',
    self: userName
    messages: messager.getMessages()
    users: userList.getUsers()

  userList.on 'add', (user) ->
    socket.emit('add_user', user)
  userList.on 'remove', (user) ->
    socket.emit('remove_user', user)
  messager.on 'add', (message) ->
    socket.emit('add_message', message)
  commander.on 'username', (oldUserName, newUserName) ->
    return if oldUserName != userName
    message = ":: #{userName} => #{newUserName} ::"
    broadcast({user: 'System', text: message})
    userList.removeUser(oldUserName)
    userList.addUser(newUserName)
    userName = newUserName


  # client to server
  socket.on 'command', (command) ->
    commander.process(command, userName)
  socket.on 'disconnect', ->
    userList.removeUser(userName)


# start us off!
app.listen(1337)
console.log("Express server started on #{app.address().port}.")

