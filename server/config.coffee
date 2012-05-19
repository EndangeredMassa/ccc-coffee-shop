exports.configure = (express, app) ->
  app.configure ->
    app.set 'views', "#{__dirname}/views"
    app.set 'view engine', 'jade'
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    app.use express.static("#{__dirname}/public")

  app.configure 'development', ->
    app.use express.errorHandler
      dumpExceptions: true
      showStack: true

  app.get '/', (request, response) ->
    response.render 'index'

