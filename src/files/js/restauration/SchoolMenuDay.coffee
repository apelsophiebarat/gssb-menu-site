{normalizeKeys,weekdayName} = require './utils'
MenuCourse = require './MenuCourse'

class SchoolMenuDay
  constructor: (@date,@week,@courses) ->

  @parse: (raw,week) ->
    raw = normalizeKeys(raw)
    coursesForAll = []
    coursesForAll = MenuCourse.parse(raw.tous) if raw.tous
    days = []
    for date in week.days()
      dayName=weekdayName(date)
      if raw[dayName]
        courses = MenuCourse.parse(raw[dayName])
        courses = courses.concat(coursesForAll)
        courses = MenuCourse.sortByType(courses)
        day = new SchoolMenuDay(date,week,courses)
        days.push(day)
    return days

module.exports = SchoolMenuDay

