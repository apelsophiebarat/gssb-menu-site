#use jquery, date.format
jQuery ($) ->
  $(document).ready ->    
    know = new Date().format('isoDate')
    today = $("##{know}")
    if(today.length>0)
      today.append("<span class='badge pull-right'>Aujourd'hui</span>")
      today.scrollView()