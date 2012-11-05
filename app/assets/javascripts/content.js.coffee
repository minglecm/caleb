# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('a.credits').on 'click', ->
    $('.navigation-tabs li.active a').css('background-color', '')
    $('.navigation-tabs li.active').removeClass('active')