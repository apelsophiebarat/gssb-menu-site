_ = require 'lodash'

class SchoolLevel
  constructor: (@levels) ->

  trim = (s) -> s.trim()
  lower = (s) -> s.toLowerCase()

  @parse: (raw) ->
    levels = @allLevelKeys()
    if _.isString(raw)
      levels = _(raw.split(',')).map(trim).map(lower).intersection(@allLevelKeys()).value()
    else if _.isArray(raw)
      levels = _(raw).map(trim).map(lower).intersection(@allLevelKeys()).value()
    new SchoolLevel(levels)

  @allLevelKeys: -> ['primaire','college','lycee']

  toString: -> JSON.stringify(@)

module.exports = SchoolLevel