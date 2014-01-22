#use jquery, date.format
jQuery ($) ->
  $.fn.scrollView = ->
    @each ->
      navOffset = parseInt $('body').css('padding-top').replace('px', '')
      scrollDuration = 1500
      $('html, body').animate({
        scrollTop: $(this).offset().top - navOffset
      }, scrollDuration)