###
TODO
pour chaque menu ajouter une url pour chaque jour de la semaine
de cette maniere on peut trouver le menu du jour par l'url
###

serverExtend: (opts) ->
        var codeBadRequest, codeRedirectPermanent, codeRedirectTemporary, codeSuccess, docpad, request, server;
        {server} = opts
        docpad = @docpad
        request = require 'request'
        codeSuccess = 200
        codeBadRequest = 400
        codeRedirectPermanent = 301
        codeRedirectTemporary = 302

        server.all('/pushover', (req, res) ->

          if (__indexOf.call(docpad.getEnvironments(), 'development') >= 0 || (process.env.BEVRY_PUSHOVER_TOKEN != null) === false) {
            return res.send(codeSuccess);
          } return request({
            url: "https://api.pushover.net/1/messages.json",
            method: "POST",
            form: extendr.extend({
              device: process.env.BEVRY_PUSHOVER_DEVICE || null,
              token: process.env.BEVRY_PUSHOVER_TOKEN,
              user: process.env.BEVRY_PUSHOVER_USER_KEY,
              message: req.query
            }, req.query)
          }, function(_req, _res, body) {
            return res.send(body);
          });
        });
         return request({
            url: "https://api.pushover.net/1/messages.json",
            method: "POST",
            form: extendr.extend({
              device: process.env.BEVRY_PUSHOVER_DEVICE || null,
              token: process.env.BEVRY_PUSHOVER_TOKEN,
              user: process.env.BEVRY_PUSHOVER_USER_KEY,
              message: req.query
            }, req.query)
          }, function(_req, _res, body) {
            return res.send(body);
          });
        });

}