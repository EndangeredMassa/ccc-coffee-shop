{Moody} = require_root('app/plugins/moody')

describe Moody, ->
  beforeEach ->
    @moody = new Moody

  it 'knows good words', ->
    mood = @moody.test('happy')
    expect(mood).toBe(1)

  it 'knows bad words', ->
    mood = @moody.test('sad')
    expect(mood).toBe(-1)
    
  it 'ignores other words', ->
    mood = @moody.test('pickles')
    expect(mood).toBe(0)

  it 'averages the mood', ->
    @moody.feel('sad')
    @moody.feel('joy')
    @moody.feel('happy')
    @moody.feel('joy')
    expect(@moody.getMood()).toBe(2)

  it 'parses a series of words', ->
    message = 'pork sad happy pickles joy'
    @moody.feel(message)
    expect(@moody.getMood()).toBe(1)

  describe 'can tell you how it feels', ->
    it 'says happy things if mood level is >= 5', ->
      expressed = null
      moody = new Moody (message) ->
        expressed = message
      moody.feel('happy happy joy joy happy')
      waitsFor ->
        expressed? && expressed.text == 'This place makes me happy.'
    
    it 'says sad things if mood level is <= -5', ->
      expressed = null
      moody = new Moody (message) ->
        expressed = message
      moody.feel('sad awful sad sad awful')
      waitsFor ->
        expressed? && expressed.text == 'This place makes me sad.'


