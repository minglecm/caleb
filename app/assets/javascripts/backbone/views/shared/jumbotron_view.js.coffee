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

    @getWordElement().text('- loading -')
    @getWordElement().closest('h1').css('font-size', @calculateFontSize('- loading -') + 'px')
    @showTitle =>
      @wordClick()

    return this

  wordClick: =>
    return if @showingAll
    currentWord = @getWordElement().text()
    currentIndex = _.indexOf(@words, currentWord)
    next = currentIndex + 1
    next = 0 if next > (@words.length - 1)
    fontSize = @calculateFontSize(@words[next])
    @getWordElement().animate {opacity: 0, height: 0}, =>

      actions = =>
        @setRandomColor()
        @getWordElement().text(@words[next])

      if fontSize > parseInt(@getWordElement().closest('h1').css('font-size').replace('px', ''), 10)
        actions()
        @getWordElement().animate {opacity: 1, height: fontSize}, =>
          @animateFontSize fontSize
      else
        @animateFontSize fontSize, =>
          actions()
          @getWordElement().animate {opacity: 1, height: fontSize}

  setRandomColor: ->
    color = '#'+Math.floor(Math.random()*16777215).toString(16)
    Utils.changeHeaderColor(color)
    @getWordElement().css('color', color)

  showAll: ->
    @$el.html('')
    @showingAll = true
    for word in @words
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

  testFontSize: (word, fontSize) ->
    container = $('<span />').text(@wordTemplate.replace('{placeholder}', word))
    container.css('font-size', fontSize + 'px')
    container.css('font-weight', 'bold')
    container.css('display', 'none')
    $('body').append(container)
    width = container.width();
    container.remove()
    width

  calculateFontSize: (newWord) ->
    fontSize = 72
    while @testFontSize( newWord, fontSize ) > 690
      fontSize--
    fontSize

  showTitle: (callback) ->
    @getWordElement().closest('h1').fadeIn(callback)

  animateFontSize: (fontSize, finishedCallback = ->) ->
    @getWordElement().closest('h1').animate({'fontSize': "#{fontSize}px"}, finishedCallback)