#use jquery, date.format
jQuery ($) ->
  $.fn.scrollView = ->
    @each ->
      navOffset = parseInt $('body').css('padding-top').replace('px', '')
      scrollDuration = 1500
      $('html, body').animate({
        scrollTop: $(this).offset().top - navOffset
      }, scrollDuration)

jQuery ($) ->
  $.fn.urlExists = (url) ->
    $.ajax(type: 'HEAD',url: url)

#if window.location.pathname == '/' or window.location.pathname.indexOf("today") > -1
#  window.location.replace("{{site.url}}/restauration/menus/2014-01-27-menu-primaire-college-lycee.html")
