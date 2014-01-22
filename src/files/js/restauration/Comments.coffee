_ = require 'lodash'
{normalizeKeys,mTrim} = require './utils'

class Comments
  constructor:(texts) -> @texts = (texts or [])

  parseComments = (raw,array)->
    array ?= []
    if _.isString(raw)
      array.push(raw.trim())
      return array
    else if _.isArray(raw)
      return array.concat(_(raw).map(mTrim).value())
    else
      return array

  @parsedKeys: -> ['remarque','commentaire','comment']

  @parse:(raw) ->
    return new Comments() unless raw
    if _.isString(raw) or _.isArray(raw)
      return new Comments(parseComments(raw))
    else if _.isObject(raw)
      nRaw = normalizeKeys(raw)
      comments = []
      for key in @parsedKeys()
        comments = parseComments(nRaw[key],comments)
      new Comments(comments)

  toString: -> JSON.stringify(@)

module.exports = Comments