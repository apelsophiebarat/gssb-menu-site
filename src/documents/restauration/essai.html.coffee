---
referencesOthers:true
render:false
write:false
---
_ = @require('underscore')
inspect = @require('util').inspect
doctype 5
html ->
  body ->
    models = @getCollection('isMenu').models
    menusChain = _.chain(models).filter((doc)->doc.get('menu')?).map((m)->m.get('menu'))
    levels = menusChain.map((m)->m.schoolLevels).flatten().uniq().value()
    console.log "levels=#{levels}"
    for level in levels
      h2 level
      menusForLevelChain = menusChain.filter((m)->level in m.schooLevels)
      years = menusForLevelChain.map((m)->m.week.from.year()).uniq().value()
      console.log "years=#{years}"
      for year in years
        h3 year
        menusForYearChain = menusForLevelChain.filter((m)-> m.week.from.year() == year)
        months =  menusForYearChain.map((m)->m.week.from.month()+1).value()
        console.log "months=#{months}"
        for month in months
          h4 month
          menusForMonth = menusForYearChain.filter((m)->m.week.from.month()+1 == month).value()
          ul ->
            for menu in menusForMonth
              title = menu.formatter.toJSON().title.standard
              li ->
                a(href:menu.meta.url, title)

