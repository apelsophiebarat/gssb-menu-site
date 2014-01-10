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
