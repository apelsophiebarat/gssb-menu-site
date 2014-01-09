_ = require 'underscore'
moment = require 'moment'
cson = require 'cson'

asMoment = (date) ->
  date =? new Date
  if moment.isMoment(date) then date
  else moment(date)

weekdayName = (date) -> asMoment(date).format('dddd')

removeFromArray = (elem,arr) ->
	pos = arr?.indexOf(elem)
	if pos then arr.splice(pos,1)
	else arr

titre = (menu) ->
	"Menu de la semaine du #{menu.week.from.format('DD MMMM YYYY')} au #{menu.week.to.format('DD MMMM YYYY')}"

class MenuOfTheDay
	constructor: (date) ->
		@day = asMoment(date)
		@plats = []
		@legumes = []

	addPlat: (plat) ->
		@plats.push(plat) if plat
		@

	addLegume: (legume) ->
		@legumes.push(legume) if legume
		@

	removePlat: (plat) ->
		@plats = removeFromArray(plat, @plats)
		@

	removeLegume: (legume) ->
		@legumes = removeFromArray(legume, @legumes)
		@

class MenuOfTheWeek
	constructor: (@week, @days, @comments) ->

	@fromCSON: (data) ->
		obj = cson.parse(data)
		@fromObj(obj)

	@fromJSON: (data) ->
		obj = JSON.parse(data)
		@fromObj(obj)

	@fromObj: (obj) ->
		week = Week.fromDateString(obj.du,'DD/MM/YYYY')
		days = []
		for day in week.days()
			motd = new MenuOfTheDay(day)
			data = obj[weekdayName(day)]
			if data
				motd.addPlat(plat) for plat in data.plats
				motd.addLegume(legume) for legume in data.legumes
			days.push(motd)
		comments = obj.remarques or []
		new MenuOfTheWeek(week,days,comments)

	toJSON: () ->
		JSON.stringify @toObject()

	toCSON: () ->
		cson.stringifySync @toObject()

	toObject: () ->
		obj =
			titre: titre(@)
			du: @week.from.format('DD/MM/YYYY')
			au: @week.to.format('DD/MM/YYYY')
			remarques: @comments
		for motd in @days
			key = weekdayName(motd.day)
			obj[key] =
				plats: motd.plats
				legumes: motd.legumes
		obj

