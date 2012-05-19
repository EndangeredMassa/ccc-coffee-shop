class Moody
  @toString: -> 'Moody'
  constructor: (@voice) ->
    @moodLevel = 0

  goodWords: [
    'happy'
    'joy'
  ]

  badWords: [
    'sad'
    'awful'
  ]

  test: (word) ->
    return 1 if @goodWords.indexOf(word) > -1
    return -1 if @badWords.indexOf(word) > -1
    return 0

  feel: (message) ->
    for word in message.split(' ')
      @moodLevel += @test(word)
    @express()

  express: ->
    if @moodLevel >= 5
      @voice
        user: 'Moody'
        text: 'This place makes me happy.'
    if @moodLevel <= -5
      @voice
        user: 'Moody'
        text: 'This place makes me sad.'

  getMood: ->
    @moodLevel

exports.Moody = Moody
