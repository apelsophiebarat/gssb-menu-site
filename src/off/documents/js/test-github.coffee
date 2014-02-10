env = require 'node-env-file'
Github = require 'github-api'
Q = require 'q'

env(__dirname + '/.env')

github = new Github(
  username: "evantill",
  password: process.env.GITHUB_PASSWORD,
  auth: "basic"
)

repo = github.getRepo("evantill", "menu")

deferred = Q.defer()

repoWriteCb = (err) ->
  if(err)
    console.log(JSON.stringify(err))
    deferred.reject(err)
  else
    console.log("done")
    deferred.resolve('menus/menu3.json')

repo.write('master',
  'menus/menu3.json',
  '{message:"hello there '+process.argv[2]+'"}',
  'create new menu',
  repoWriteCb)

repoReadCb = (err, data) ->
  if(err)
    console.log(JSON.stringify(err))
  else
    console.log(data)

Q.when(deferred.promise,
  (value) ->
    repo.read('master', 'menus/menu3.json', repoReadCb)
)
