# Your [DocPad](http://docpad.org) Project

## License
Copyright &copy; 2013+ All rights reserved.

## Heroku

### Maintenance mode

- configuration: `heroku config:set MAINTENANCE_PAGE_URL=http://apel.s3-website-eu-west-1.amazonaws.com/heroku/menu/maintenance.html`
- activate maintenance mode: `heroku maintenance:on`
- desactivate maintenance mode: `heroku maintenance:off`
- check mode: `heroku maintenance`

### custom error page

`heroku config:set ERROR_PAGE_URL=http://apel.s3-website-eu-west-1.amazonaws.com//heroku/menu/erreur.html`

