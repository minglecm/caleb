window.Utils = {
  changeHeaderColor: (color) ->
    color ||= '#'+Math.floor(Math.random()*16777215).toString(16)
    $('.site-name').css('color', color)
    $('a').css('color', color)
    $('.navigation-tabs li.active a').css('background-color', color)
    $('.navigation-tabs li:not(.active) a').css('color', color)
    $('.navigation-tabs li.active a').css('color', 'white')
}