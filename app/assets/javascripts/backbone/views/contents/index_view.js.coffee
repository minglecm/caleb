Caleb.Views.Contents ||= {}

class Caleb.Views.Contents.IndexView extends Caleb.Views.ContentView
  template: JST["backbone/templates/contents/index"]

  events: {
    "click .jumbotron-nav a.make": "showMakeJumbotron"
    "click .jumbotron-nav a.use": "showUseJumbotron"
    "click .jumbotron-nav a.enjoy": "showEnjoyJumbotron"
  }

  showMakeJumbotron: ->
    @$('.jumbotron').html(new Caleb.Views.Contents.Jumbotron.MakeView().render().el)
    @updateActiveJumbotronTab('make')

  showUseJumbotron: ->
    @$('.jumbotron').html(new Caleb.Views.Contents.Jumbotron.UseView().render().el)
    @updateActiveJumbotronTab('use')

  showEnjoyJumbotron: ->
    @$('.jumbotron').html(new Caleb.Views.Contents.Jumbotron.EnjoyView().render().el)
    @updateActiveJumbotronTab('enjoy')

  updateActiveJumbotronTab: (tab) ->
    @$(".jumbotron-nav li.active").removeClass('active')
    @$(".jumbotron-nav a.#{tab}").parent().addClass('active')

  render: ->
    super
    @showMakeJumbotron()
    return this