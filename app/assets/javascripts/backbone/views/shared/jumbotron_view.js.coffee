Caleb.Views.Contents ||= {}

class Caleb.Views.Contents.JumbotronView extends Backbone.View
  template: JST["backbone/templates/contents/jumbotron/layout"]
  events:
    "click h1.title span" : 'wordClick'

  words: []
  wordTemplate: "{placeholder}"
  slogan: ""

  initialize: ->
    @words = _.shuffle(@words)

  render: ->
    $(@el).html(@template({wordTemplate: @wordTemplate, slogan: @slogan}))

    @changeWord('- loading -')
    @showTitle =>
      @changeWord(@words[0])

    return this

  getWordElement: ->
    @$('.title span')

  wordClick: =>
    currentWord = @getWordElement().text()
    currentIndex = _.indexOf(@words, currentWord)
    next = currentIndex + 1
    next = 0 if next > (@words.length - 1)
    @changeWord @words[next]

  setAndAnimate: (newWord, callback) ->
    $element = @getWordElement()

    actions = =>
      color = '#'+Math.floor(Math.random()*16777215).toString(16)
      Utils.changeHeaderColor(color)
      $element.text(newWord)
      $element.css('color', color)
      $element.slideDown callback

    if $element.text() == ''
      $element.slideUp()
      actions()
    else
      $element.slideUp actions

  changeWord: (newWord) ->
    fontSize = 72
    while @testFontSize( newWord, fontSize ) > 690
      fontSize--

    if fontSize > parseInt(@getWordElement().parent().css('font-size').replace('px', ''), 10)
      @setAndAnimate newWord, => @getWordElement().parent().animate({'fontSize': "#{fontSize}px"})
    else
      @getWordElement().parent().animate {'fontSize': "#{fontSize}px"}, =>
        @setAndAnimate newWord, ->

  testFontSize: (word, fontSize) ->
    container = $('<span />').text(@wordTemplate.replace('{placeholder}', word))
    container.css('font-size', fontSize + 'px')
    container.css('font-weight', 'bold')
    container.css('display', 'none')
    $('body').append(container)
    width = container.width();
    container.remove()
    width

  showTitle: (callback) =>
    @getWordElement().parent().fadeIn(callback)