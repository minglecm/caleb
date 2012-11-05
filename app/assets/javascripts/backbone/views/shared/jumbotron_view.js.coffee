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
    @showingAll = false

  render: ->
    $(@el).html(@template({wordTemplate: @wordTemplate, slogan: @slogan}))

    @changeWord('- loading -')
    @showTitle =>
      @changeWord(@words[0])

    return this

  showAll: ->
    @$el.html('')
    @showingAll = true
    for word in @words
      # create h1
      # measure size of word
      $element = $('<h1 />').addClass('title').html('<span></span>')
      $span    = $element.find('span')
      fontSize = 72
      while @testFontSize( word, fontSize ) > 690
        fontSize--
      $element.css('font-size', "#{fontSize}px")
      $span.css('color', '#'+Math.floor(Math.random()*16777215).toString(16))
      $span.text(word)

      @$el.append($element)
      $element.fadeIn()

  getWordElement: ->
    @$('.title span')

  wordClick: =>
    return if @showingAll
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