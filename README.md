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

TODO
===

The following features would be nice to have. Numbers are for reference, not priority.

1. Whispers: Add the ability to whisper to another user by name. Use the format: `/whisper <name> <message>`
1. Ignore: Add the ability to ignore, list and unignore ignored users. Use the following syntax: `/ignore user` which toggles ignore status on that user; `/ignore` which lists all ignored users
1. Authenticate: Add the ability to authenticate yourself instead of supplying a username. Also change the way users are displayed so that authenticated users are recognizable as such.
1. Signal to Noise: Create a global chat filter that will prevent any message from being sent if it matches any previous message exactly. See XKCD's signal-to-noise chat room experiment. Provide an option to turn this off either with a config file or a chat command.
1. Tone Finder: This bot will read all chat messages and do some natural language processing to determine the tone of the conversation. When asked, the bot will reply with the current tone. The example plugin (Moody) is a very basic version of this. To complete this feature, update that plugin to be more robust. Use the following syntax: /tone
1. Chatbot: Hook up a bot that acts like a normal chatbot. Try to connect to an existing chatbot, unless you really want to write your own.
1. Create a trivia bot that will pose questions to the room and reveal the answer after X seconds. It should keep score and determine a winner after Y rounds. The bot will only consider messages directed to it, like so: `@trivia_bot Naples`
1. Die Roller: Create a bot that will respond with a die result. Use the following syntax: `/roll 3d8+2` => `@user_that_rolled 9`
1. JavaScript Console: Create a bot that will execute javascript from the chatroom in a secure environment. Use the following syntax: `js> var a=23; 5+a` => `@user_that_asked 28`
1. CoffeeScript Console: Create a bot that will execute coffeescript from the chatroom in a secure environment. Use the following syntax: `coffee> a=23; 5+a` => `@user_that_asked 28`
1. Googlebot: Create a bot that will return the link and summary of the first result of a google search. Use the following syntax: `? <some search term>` => `@user_that_queried http://somesite.com`
1. Stock Price Checker: Create a bot that will return the current stock price given a ticker. Use the following syntax: `%MSFT` => `@user_that_asked $30.05`
1. Youtube Visualizer: Create a view for links to youtube videos. These should render the video inside the chat window, along with the title and description.
1. Imgur Visualizer: Create a new view for links to Imgur images. Render the images in the chat with a link to view the full size image.
1. Wikipedia Visualizer: Create a new view for links to Wikipedia. Show a thumbnail, title, and description of the article.
1. Stack Overflow Visualizer: Create a new view for links to StackOverflow questions. Show the title, description, tags, vote count, and view count.
1. Edit Messages: Allow users to edit previous posts. Update those posts on all clients.
1. File Sharing: Allow users to upload files (with a special view showing them) and other users to download those files.
1. Show/Hide the enter/leave messages: Add the feature to display a message when a user enters or leaves the room. At the same time, allow any give use the ability to hide those messages on their individual view. This can be done client-side with a checkbox and an event.
1. Allow Replies: Allow users to reply to other users (making the message take on a different color) as well as specific posts. If a reply exists to a specific post, mouseovering either post will highlight both of them. See the StackOverflow chat system.
1. IRC Compliance: Make the chat server support the IRC protocol. This can be done manually or by integrating an IRC library. http://gf3.github.com/IRC-js/IRC/prototype/topic/
1. Script Injection: There is a script inject vulnerability in the application. The messages are passed around as raw text. So, any HTML (including script tags) is rendered on all clients when sent. Fix this by sanitizing the message text before sending it back out to the world.
1. Integration Tests: There is already a setup for integration tests with Zombie.js, but it doesn't work perfectly. Investigate what it will take to get this working for our features and implement it. You can start by looking at the script/run_server_specs.sh script as well as the spec/server/ test directory.
1. Persistance: Right now, all messages are stored in memory. Add an option to swap out the default Memory Messager with a Redis (or something else) backed Messager.
1. Title Bar Notification: Users should receive a notification in their title bar when a new message has arrived

