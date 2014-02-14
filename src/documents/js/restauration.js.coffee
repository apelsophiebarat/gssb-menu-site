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

loadMenuForTodayFromUrls = (urls) ->
  url = urls.pop()
  $('#menu-for-today').load url,null,(responseTxt,statusTxt,xhr) ->
    if statusTxt == 'success' then scrollToToday()
    else if urls.length > 0 then loadMenuForTodayFromUrls(urls)
    else $('#menu-for-today').replaceWith $('#menu-for-today-notfound')

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
