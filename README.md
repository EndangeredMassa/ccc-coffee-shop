Coffee Shop
===

A chat server written in CoffeeScript with a focus on TDD over simple domain objects.

Getting Started
==
1. Install node.js 0.6.18 http://nodejs.org/
1. fork the repo: https://github.com/EndangeredMassa/ccc-coffee-shop
1. clone your forked repo
1. `cd ccc-coffee-shop && npm install`
1. (optional) `bundle install`
1. `npm test` # make sure it all passes
1. `npm start` # run the server
1. visit `localhost:1337` in your browser

Testing
==
1. `npm test`

Structure
===
```
├── app
│   ├── commander.coffee
│   ├── messager.coffee
│   ├── plugins
│   └── user_list.coffee
├── client
│   └── chat.coffee
├── script
│   ├── compile_coffee
│   ├── run_server_specs.sh
│   ├── spec_app.watchr
│   ├── spec_server.watchr
│   ├── start_application.sh
│   └── stop_application.sh
├── server
│   ├── config.coffee
│   ├── index.coffee
│   ├── package.json
│   ├── public
│   └── views
└── spec
    ├── app
    ├── server
    └── spec_helper.js
```

The structure of this app is deliberate.

/app holds the core business objects. These are directly TDD'd from the spec/app directory. They don't know they are being used by a server at all.

/client holds the client-side scripts. It's compiled down into server/public/js so that the server can serve it.

/script holds utilities for running the server and the tests.

/server is a separation of concerns. All server-specific code goes in here. It's mostly wiring the business objects together and responding to server-y events.

/spec holds all of the unit (/app) and integration(/server) tests. Currently, the integration tests are incomplete.
