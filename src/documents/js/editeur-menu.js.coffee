datepickerConfig = {
  format: "dd/mm/yyyy"
  weekStart: 1
  todayBtn: "linked"
  language: "fr"
  orientation: "top left"
  daysOfWeekDisabled: "0,6"
  autoclose: true
  todayHighlight: true
  beforeShowDay: (date) ->
    if date.getMonth() == (new Date()).getMonth()
      switch date.getDate()
        when 4
          {
            enable: true
            tooltip: 'Example tooltip'
            classes: 'active'
          }
        when 8 then false #not selectable
        when 12 then "green"
        else undefined
}

$('#menu-container .input-group.date').datepicker(datepickerConfig)