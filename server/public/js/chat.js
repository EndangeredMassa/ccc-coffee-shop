(function() {
  var addMessage, addUser, initialize, socket;

  initialize = function() {
    var $command;
    $command = $('#command');
    $command.focus();
    return $command.on('keyup', function(event) {
      var $this;
      if (event.keyCode !== 13) return;
      $this = $(this);
      if ($this.val() !== '') {
        socket.emit('command', $this.val());
        return $this.val('');
      }
    });
  };

  socket = io.connect('http://#{window.location.host}');

  socket.on('init', function(data) {
    var message, user, userName, _i, _j, _len, _len2, _ref, _ref2, _results;
    userName = data.self;
    _ref = data.users;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      user = _ref[_i];
      addUser(user);
    }
    _ref2 = data.messages;
    _results = [];
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      message = _ref2[_j];
      _results.push(addMessage(message.user, message.text));
    }
    return _results;
  });

  socket.on('add_user', function(user) {
    return addUser(user);
  });

  socket.on('remove_user', function(user) {
    return $('#users #' + user).remove();
  });

  socket.on('add_message', function(message) {
    return addMessage(message.user, message.text);
  });

  addUser = function(user) {
    var $user;
    $user = $('<div />');
    $user.attr('id', user);
    $user.html(user);
    return $('#users').append($user);
  };

  addMessage = function(user, message) {
    var $msg;
    $msg = $('<tr />');
    $msg.html("<td class='username'>" + user + "</td><td class='message'>" + message + "</td>");
    return $('#messages').append($msg);
  };

  $(function() {
    return initialize();
  });

}).call(this);
