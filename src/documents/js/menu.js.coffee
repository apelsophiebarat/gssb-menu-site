#use jquery, date.format
window.scrollToToday = scrollToToday = () ->
  know = moment().format('YYYY-MM-DD')
  today = $("##{know}")
  if(today.length>0)
    today.append("<span class='badge pull-right'>Aujourd'hui</span>")
    today.scrollView()

loadMenuForTodayFromUrls = (urls) ->
  url = urls.pop()
  $('#menu-for-today').load url,null,(responseTxt,statusTxt,xhr) ->
    if statusTxt == 'success' then scrollToToday()
    else if urls.length > 0 then loadMenuForTodayFromUrls(urls)
    else $('#menu-for-today').replaceWith $('#menu-for-today-notfound')

loadMenuForDate = (schoolLevel,menuDate) ->
  dateStr = menuDate.toISOString().split('T')[0]
  urls = [
    "menus/#{dateStr}-menu-#{schoolLevel}-partial.html",
    "menus/#{dateStr}-menu-partial.html"
  ]
  loadMenuForTodayFromUrls(urls.reverse())

window.loadMenuForToday = loadMenuForToday = (schoolLevel) ->
  loadMenuForDate(schoolLevel,new Date)

window.loadMenuForThisWeek = loadMenuForThisWeek = (schoolLevel) ->
  loadMenuForDate(schoolLevel,moment().weekday(1))
  
