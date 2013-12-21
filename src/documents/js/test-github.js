var env = require('node-env-file');
var Github = require('github-api');
var Q = require('q');

env(__dirname + '/.env');

var github = new Github({
  username: "evantill",
  password: process.env.GITHUB_PASSWORD,
  auth: "basic"
});

var repo = github.getRepo("evantill", "menu");

var deferred = Q.defer();

repo.write('master', 'menus/menu3.json', '{message:"hello there '+process.argv[2]+'"}', 'create new menu', function(err) {
  if(err) {
    console.log(JSON.stringify(err));
    deferred.reject(err);
  } else {    
    console.log("done");
    deferred.resolve('menus/menu3.json');
  }
});



Q.when(deferred.promise, function (value) {
  repo.read('master', 'menus/menu3.json', function(err, data) {
    if(err){
      console.log(JSON.stringify(err));
    } else {
      console.log(data);
    }
  });
});