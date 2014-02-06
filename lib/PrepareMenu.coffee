_ = require 'underscore'
extendr = require 'extendr'

joinArray = (array,sep=',',prefix='',suffix='',lastSep=sep) ->
    return '' unless array and array.length > 0
    array = [].concat(array)
    if array.length > 1
      lastElem = array.pop()
      joinedArray = [array.join(sep),lastElem].join(lastSep)
    else
      joinedArray = array.join(sep)
    [prefix,joinedArray,suffix].join('')

module.exports =
  class PrepareMenu
    @prepare: (content, options) ->
      unless options?
        options = content
        content = this
      menu = content
      return '' unless menu?.isMenu
      prepared = new PrepareMenu(menu).prepared
      options.fn(prepared)

    constructor: (menu) ->
      @menu = menu
      @prepare(extendr.deepClone(menu))

    prepare: (menu) ->
      @prepared = menu
      @prepareTitle()
      @prepareDescription()
      @prepareNavTitle()
      @prepareLongTitle()
      @prepareLongTitleWithTags()
      @prepareShortTitle()
      @prepareTagsForTitle()
      @prepareCourses()
      @prepared

    @prepareMenuTitle: (menu) ->
      week = menu.week
      from = week.from.format('DD/MM/YYYY')
      to = week.to.format('DD/MM/YYYY')
      schoolLevels = joinArray(menu.schoolLevels,', ',' pour le ','',' et le ')
      "Menu du #{from} au #{to}#{schoolLevels}"

    prepareTitle: ->
      @prepared.title =
        PrepareMenu.prepareMenuTitle(@prepared)

    @prepareMenuDescription: (menu) ->
      week = menu.week
      from = week.from.format('dddd DD MMMM YYYY')
      to = week.to.format('dddd DD MMMM YYYY')
      schoolLevels = joinArray(menu.schoolLevels,', ',' pour le ','',' et le ')
      "Menu du #{from} au #{to}#{schoolLevels}"

    prepareDescription: ->
      @prepared.description =
        PrepareMenu.prepareMenuDescription(@prepared)

    prepareNavTitle: ->
      menu= @prepared
      week = menu.week
      from = week.from.format('DD MMM YYYY')
      to = week.to.format('DD MMM YYYY')
      menu.navTitle = "#{from} --> #{to}"

    prepareMenuLongTitle = (menu, optSchoolLevels='') ->
      week = menu.week
      from = week.from.format('dddd DD MMMM YYYY')
      to = week.to.format('dddd DD MMMM YYYY')
      "Menu #{optSchoolLevels} de la semaine du #{from} au #{to}"

    prepareLongTitleWithTags: ->
      menu= @prepared
      schoolLevels = joinArray(menu.schoolLevels,', le ',' pour le ','',' et le ')
      menu.longTitleWithTags = prepareMenuLongTitle(menu,schoolLevels)

    prepareLongTitle: ->
      menu= @prepared
      menu.longTitle = prepareMenuLongTitle(menu)

    prepareShortTitle: ->
      menu= @prepared
      week = menu.week
      from = week.from.format('DD MMM')
      to = week.to.format('DD MMM YYYY')
      menu.shortTitle = "Menu du #{from} au #{to}"

    prepareTagsForTitle: ->
      menu= @prepared
      menu.tagsForTitle = menu.schoolLevels.join(', ')

    prepareCourses: ->
      for day in @prepared.days
        courses = day.courses
        grouped = _.chain(courses).sortBy((c)->c.order).groupBy('type').value()
        day.coursesGroupedByType = for type,groupedCourses of grouped
          groupedCourse =
            type: type
            courses: grouped[type]
      @prepared

