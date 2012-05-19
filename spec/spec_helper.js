require('coffee-script')

global.require_root = function(path) {
  var rootPath = process.env.PWD + '/' + path
  return require (rootPath)
}

global.p = console.log
jasmine.getEnv().defaultTimeoutInterval = 300

beforeEach(function(){
  this.addMatchers({
    toContain: function() {
      for(var i=0; i<arguments.length; i++) {
        if (this.actual.indexOf(arguments[i]) === -1)
          return false;
      }
      return true;
    }
  });
});

