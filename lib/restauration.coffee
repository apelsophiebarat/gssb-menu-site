###
{
  titre: "..."
  remarques: "..."
  jours: [
    {
      jour: "Lundi"
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

prepareMenu = (data) ->
  output = {
    titre: data.titre
    remarques: data.remarques
    jours: prepareDays(data)
  }

prepareDays = (data) ->
  days = []
  for day in ["Lundi","Mardi","Mercredi","Jeudi","Vendredi"]
    if data[day]
      days.push(prepareDay(day,data[day]))
  days

prepareDay = (day,data) ->
  output = {
    jour: day
    plats: [
      preparePlats('plats',data['plats']),
      preparePlats('legumes',data['legumes'])
    ]
  }

preparePlats = (type, liste) ->
  output = {
    type: type,
    liste: for text in liste then preparePlat(type,text)
  }

preparePlat = (type,text) ->
  output = {
    type: type
    text: text
  }
  
helpers = {
  prepareMenu: (options) ->
    content = prepareMenu(@)
    options.fn(content)

}

module.exports = {
  helpers: helpers
}
