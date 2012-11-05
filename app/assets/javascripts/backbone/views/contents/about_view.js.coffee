Caleb.Views.Contents ||= {}

class Caleb.Views.Contents.AboutView extends Caleb.Views.ContentView
  template: JST["backbone/templates/contents/about"]
  events:
    "click .see-all": 'showAll'
    "click .reset" : 'resetView'

  resetView: (event) ->
    event.preventDefault()
    @render()
    @aboutJumbotron.showingAll = false

  showAll: (event) ->
    event.preventDefault()
    @aboutJumbotron.showAll()

  render: ->
    super
    @$('.jumbotron').html('')
    @aboutJumbotron = new Caleb.Views.Contents.Jumbotron.AboutView()
    @$('.jumbotron').html(@aboutJumbotron.render().el)
    @