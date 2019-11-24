# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.crash-datepicker-JS').addClass('hidden')
  $('.crash-datepicker-div-JS').datepicker
    format: 'dd.mm.yyyy'
    language: 'ru'
    keyboardNavigation: false
    todayHighlight: true
    autoclose: true
    setDate: new Date()

  $(document).on 'turbolinks:load', ->
    $('.crash-datepicker-JS').addClass('hidden')
    $('.crash-datepicker-div-JS').datepicker
      format: 'dd.mm.yyyy'
      language: 'ru'
      keyboardNavigation: false
      todayHighlight: true
      autoclose: true
      setDate: new Date()
    return
