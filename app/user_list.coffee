{EventEmitter} = require('events')

class UserList extends EventEmitter
  constructor: ->
    @users = []

  @toString: ->
    'UserList'

  addUser: (user) ->
    @users.push(user)
    @emit('add', user)

  removeUser: (targetUser) ->
    for user, index in @users
      if user == targetUser
        @users.splice(index, 1)
        @emit('remove', targetUser)
        return

    @emit('remove', null)

  getUsers: ->
    @users

exports.UserList = UserList
