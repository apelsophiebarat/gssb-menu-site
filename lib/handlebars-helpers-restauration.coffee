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
Week = require('./week')

prepareMenuData = (data) ->
  console.log('\n\n')
  date = data?.document.date or new Date
  console.log(typeof Week)
  week = new Week(date)
  output =
    du: week.from
    au: week.to
    titre: prepareTitre(week)
    remarques: data.content.remarques
    jours: prepareDays(data)

prepareTitre = (week) ->
  "Menu de la semaine du #{week.from.format('DD MMMM YYYY')} au #{week.to.format('DD MMMM YYYY')}"

prepareDays = (data) ->
  days = []
  for day in ["lundi","mardi","mercredi","jeudi","vendredi"]
    if data.content[day]
      days.push(prepareDay(day,data.content[day]))
  days

prepareDay = (day,data) ->
  output =
    jour: day
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

