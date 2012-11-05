class Caleb.Routers.ContentsRouter extends Backbone.Router
  routes:
    "index"   : "index"
    "about"   : "about"
    "credits" : "credits"
    "contact" : "contact"
    '*path'   : 'index'
  
  index: ->
    @view = new Caleb.Views.Contents.IndexView()
    $("#contents").html(@view.render().el)
    @updateTab('index')

  about: ->
    @view = new Caleb.Views.Contents.AboutView()
    $('#contents').html(@view.render().el)
    @updateTab('about')

  credits: ->
    @view = new Caleb.Views.Contents.CreditView()
    $('#contents').html(@view.render().el)

  contact: ->
    @view = new Caleb.Views.Contents.ContactView()
    $('#contents').html(@view.render().el)
    @updateTab('contact')

  updateTab: (className) ->
    $('.navigation-tabs li.active a').css('background-color', '')
    $('.navigation-tabs li.active').removeClass('active')
    $(".navigation-tabs li.#{className}").addClass('active')
    $(".navigation-tabs li.#{className} a").css('color', 'white')
    Utils.changeHeaderColor()