menuEditorApp = angular.module('MenuEditorApp',[])

menuEditorController = menuEditorApp.controller 'MenuEditorController', [
  '$scope','$http','$templateCache',($scope,$http,$templateCache) ->
    $scope.jours = ["Lundi","Mardi","Mercredi","Jeudi","Vendredi"]
    $scope.loadMenu = (name) ->
      url = '/restauration/menus/2013-12-13-menu-de-la-semaine.json'
      $http.get(url).success (rawData,status) ->
        console.log(rawData)
        console.log(rawData.content)
        data  = JSON.parse(rawData?.content)
        menu =
          jours:[]
        for jour in $scope.jours
          jourData =
            titre:jour
            data:data[jour]
          menu.jours.push jourData
        $scope.menu = menu
  ]


class Week
  constructor: (jsDate) ->
    momentDate = moment(jsDate)
    momentDate.lang('fr')
    @from = momentDate.startOf('week')
    @to = @from.clone().add(6,'day').add(-1,'second')

  isInWeek: (jsDate) =>
    date = moment(jsDate)
    @from.isBefore(date) and @to.isAfter(date)

  toString: () -> "Week("+@from.format('DD/MM/YYYY')+","+@to.format('DD/MM/YYYY')+")"

class DatePicker
  self = {}

  constructor:(@selector) ->
    self = @
    @selectDate new Date()
    $(@selector).datepicker(@datepickerConfig).on('changeDate', @onChangeDateFn)

  selectDate:(date) =>
    @selectedDate=moment(date)
    @selectedWeek=new Week(date)

  datepickerConfig:
    format: "dd/mm/yyyy"
    weekStart: 1
    todayBtn: "linked"
    language: "fr"
    orientation: "top left"
    daysOfWeekDisabled: "0,6"
    autoclose: true
    todayHighlight: false
    beforeShowDay: (jsDate) -> self.beforeShowDayCallFn(jsDate)

  beforeShowDayCallFn: (jsDate) =>
    date = moment(jsDate)
    if @selectedWeek.isInWeek(date) then "active" else undefined

  onChangeDateFn: (event) =>
    @selectDate(event?.date or new Date())
    $(@selector).datepicker('update')

new DatePicker('#menu-container #inputWeek')
