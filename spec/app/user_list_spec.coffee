{UserList} = require_root 'app/user_list'

describe UserList, ->
  beforeEach ->
    @list = new UserList

  it 'adds a user and lists all users', ->
    @list.addUser('smassa')
    @list.addUser('guest 123')
    expect(@list.getUsers()).toContain('smassa', 'guest 123')

  it 'removes a user', ->
    @list.addUser('smassa')
    @list.addUser('guest 123')
    @list.removeUser('smassa')
    users = @list.getUsers()
    expect(users.length).toBe(1)
    expect(users).toContain('guest 123')

  it 'notifies listeners on add', ->
    notified = false
    @list.on 'add', (user) ->
      notified = user
    @list.addUser('smassa')
    waitsFor -> notified == 'smassa'

  describe 'notifies listeners on remove', ->
    it 'emits null when remove call misses', ->
      missedUser = true
      @list.on 'remove', (user) ->
        missedUser = user
      @list.removeUser('smassa')
      waitsFor -> missedUser == null

    it 'emits null when remove call misses', ->
      notified = false
      @list.on 'remove', (user) ->
        notified = user
      @list.addUser('smassa')
      @list.removeUser('smassa')
      waitsFor -> notified == 'smassa'

