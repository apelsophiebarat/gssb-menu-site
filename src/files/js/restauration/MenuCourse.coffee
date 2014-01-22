_ = require 'lodash'

{mTrim,normalizeKeys,stringOrArray} = require './utils'

class MenuCourse
  constructor: (@type,@description) ->

  @allTypes = ->['starter','main','vegetable','dessert']

  @typeAlias = ->
    entree: 'starter'
    plat: 'main'
    legume: 'vegetable'
    dessert: 'dessert'

  @sortByType: (courses) ->
    sortFn = (course) -> _.findIndex(MenuCourse.allTypes(),course.type)
    _.sortBy(courses,sortFn)

  @parse: (raw) ->
    raw = normalizeKeys(raw)
    splitAndTrim = (str,sep) ->
      if(str.indexOf(sep)>-1)
        _.map(str.split(sep),mTrim)
      else
        new Array(str)
    mapAliases = (result,value,key) ->
      mKey = MenuCourse.typeAlias()[key] or key
      values = stringOrArray(value,mTrim)
      mValues = []
      mValues = mValues.concat(splitAndTrim(value,'/')) for value in values
      result[mKey] = mValues
    raw = _.transform(raw,mapAliases,{})
    courses = []
    for type in MenuCourse.allTypes()
      descriptions = raw[type] or []
      for description in descriptions
        courses.push(new MenuCourse(type,description))
    return @sortByType(courses)

  toString: -> JSON.stringify(@)

module.exports = MenuCourse