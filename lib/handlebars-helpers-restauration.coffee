###
{
  titre: "..."
  remarques: "..."
  jours: [
    {
      jour: "lundi"
      plats: [
        {
          type: "plats"
          liste: [
            {
              type: "plats"
              text: "p1"
            },{
              ...
            }
          ]
        },{
          type: "legumes"
          liste: ...
        }
      ]
    },{
      ...
    }
  ]
}
###
Week = require './week'
{today,weekdayName} = require './utils'

prepareMenuData = (data) ->
  date = data?.document.date or new Date
  week = new Week(date)
  output =
    du: week.from
    au: week.to
    titre: prepareTitre(week)
    remarques: data.content.remarques
    jours: prepareDays(week,data)

prepareTitre = (week) ->
  "Menu de la semaine du #{week.from.format('DD MMMM YYYY')} au #{week.to.format('DD MMMM YYYY')}"

prepareDays = (week,data) ->
  days = []
  for day in week.days()
    key = weekdayName(day).toLowerCase()
    if data.content[key]
      value = data.content[key]
      days.push(prepareDay(week,day,key,value))
  days

prepareDay = (week,day,dayName,data) ->
  output =
    jour: dayName
    today: -> today(day)
    jourId: -> if today(day) then 'today' else dayName
    date: day
    plats: [
      preparePlats('plats',data['plats']),
      preparePlats('legumes',data['legumes'])
    ]

preparePlats = (type, liste) ->
  output =
    type: type,
    liste: for text in liste then preparePlat(type,text)

preparePlat = (type,text) ->
  output =
    type: type
    text: text

module.exports =
  prepareMenu: (options) ->
    content = prepareMenuData(@)
    options.fn(content)



