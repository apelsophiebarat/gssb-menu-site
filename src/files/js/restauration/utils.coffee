_ = require 'lodash'
moment = require 'moment'

exports.asMoment = asMoment = (date) ->
  if date
    if moment.isMoment(date) then date
    else moment(date)
  else
    moment()

exports.weekdayName = weekdayName = (date) -> asMoment(date).format('dddd')

exports.removeFromArray = removeFromArray= (elem,arr) ->
  pos = arr?.indexOf(elem)
  if pos then arr.splice(pos,1)
  else arr

exports.today = today = (date, fmt) ->
  return false unless date
  know = moment()
  date =
    if fmt then moment(date, fmt)
    else asMoment(date)
  know.isSame(date, 'day')

exports.mTrim = trim = (s) -> s.trim()
exports.mLowerCase = lowerCase = (s) -> s.toLowerCase()
exports.mSingulize = singulize = (s) -> if s and (s.lastIndexOf('s')==s.length-1) then s.substr(_,s.length-1)  else s

exports.normalizeKeys = normalizeKeys = (data) ->
  normalizeKey = (k) -> singulize(k.trim().toLowerCase())
  nData = {}
  for k,v of data
    nk = normalizeKey(k)
    nData[nk] = v
  nData

exports.stringOrArray = stringOrArray = (value,fn) ->
  if _.isString(value)
    new Array(fn(value))
  else if _.isArray(value)
    _.map(value,fn)
  else
    []