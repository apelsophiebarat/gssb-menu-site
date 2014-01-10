moment = require 'moment'

{asMoment} = require './utils'

class Week
  constructor: (date) ->
    momentDate = asMoment(date)
    momentDate.lang('fr')
    @from = momentDate.clone().startOf('week')
    @to = @from.clone().add(5,'day').add(-1,'second')

  @fromDateString: (date, fmt) ->
    date = if(date) then moment(date,fmt) else moment()
    new Week(date)

  @fromDate: (date) ->
    new Week(asMoment(date))

  isInWeek: (date) =>
    date = asMoment(date)
    @from.isBefore(date) and @to.isAfter(date)

  days: () ->
    days=[]
    day = @from.clone()
    lastDay = @to.clone().add(-1,'second')
    while day.isBefore(lastDay)
      days.push(day.clone())
      day = day.add(1,'day')
    days

  toString: () -> JSON.stringify(@)

module.exports = Week
