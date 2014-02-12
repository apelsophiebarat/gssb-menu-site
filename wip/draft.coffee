###
TODO
pour chaque menu ajouter une url pour chaque jour de la semaine
de cette maniere on peut trouver le menu du jour par l'url
###

serverExtend: (opts) ->
  {server} = opts
  docpad = @docpad
  request = require 'request'
  codeSuccess = 200
  codeBadRequest = 400
  codeRedirectPermanent = 301
  codeRedirectTemporary = 302

  #non-www to www redirect
  server.get '/*', (req, res, next) ->
    if (req.headers.host.indexOf('www' != 0)
      res.redirect("http://www.#{req.headers.host}#{req.url}", codeRedirectPermanent)
    else
      next()
