#use jquery, date.format
window.scrollToToday = scrollToToday = () ->
  know = new Date().format('isoDate')
  today = $("##{know}")
  if(today.length>0)
    today.append("<span class='badge pull-right'>Aujourd'hui</span>")
    today.scrollView()

getMondayDateStr = (today) ->
  dayofweek = today.getDay()
  nbrOfDaysToRemoveUntilMonday = Math.abs(((1-dayofweek)-7)%7)
  monday = new Date(today.getTime())
  monday.setDate(monday.getDate()-nbrOfDaysToRemoveUntilMonday)
  return monday.toJSON().split('T')[0]

loadMenuFromUrl = (url,menuForToday) ->
  menuForToday or= $('#menu-for-today')
  menuForToday.load url,null,(responseTxt,statusTxt,xhr) ->
    if statusTxt == 'success' then scrollToToday()
    else menuForToday.replaceWith $('#menu-for-today-notfound')

loadMenuForTodayFromUrls = (urls,menuForToday) ->
  menuForToday or= $('#menu-for-today')
  url = urls.pop()
  nextUrls = urls
  if nextUrls.length>0
    onFailure = -> loadMenuForTodayFromUrls(nextUrls,menuForToday)
  else
    onFailure = -> menuForToday.replaceWith $('#menu-for-today-notfound')
  onDone = -> loadMenuFromUrl(url,menuForToday)
  menuForToday.urlExists(url).then(onDone,onFailure)

window.loadMenuForToday = loadMenuForToday = (schoolLevel) ->
  today = new Date()
  mondayStr = getMondayDateStr(today)
  dateStr = today.toJSON().split('T')[0]
  urls = [
    "../menus/#{dateStr}-menu-#{schoolLevel}-partial.html",
    "../menus/#{dateStr}-menu-partial.html",
    "../menus/#{mondayStr}-menu-#{schoolLevel}-partial.html",
    "../menus/#{mondayStr}-menu-partial.html"
  ]
  loadMenuForTodayFromUrls(urls.reverse())
