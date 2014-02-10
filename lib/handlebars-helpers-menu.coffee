_ = require 'underscore'

module.exports =
  helpers:
    ###
     TODO :
        dupliquer les entrees pour chaque valeur de schoolLevels
        grouper par schoolLevel
          pour chaque schoolLevels
            grouper par annees
              pour chaque annees
                grouper par mois
    ###
    groupMenuForArchive: (collectionName) ->
      menuDocuments = @getCollection(collectionName).toJSON()
      return [] unless menuDocuments?.length >0
      separateByTagValues = (coll) ->
        output=[]
        for elem in coll
          menu = elem.menu
          for schoolLevel in menu.schoolLevels
            output.push
              keys:
                schoolLevel: schoolLevel
                year: menu.week.from.year()
                month: menu.week.from.month()+1
              content: menu
        return output
      menusWithKeys = separateByTagValues(menuDocuments)
      groupByTags = (coll) -> _.chain(coll).groupBy('keys.schoolLevel').each(groupByYear).value()
      groupByYear = (coll,schoolLevel) -> _.chain(coll).groupBy('keys.year').each(groupByMonth).value()
      groupByMonth = (coll,year) -> _.groupBy(coll,'keys.month')
      grouped = groupByTags(menusWithKeys)
      return grouped


