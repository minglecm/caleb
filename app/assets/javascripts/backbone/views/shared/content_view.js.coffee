Caleb.Views ||= {}

class Caleb.Views.ContentView extends Backbone.View
  render: ->
    $(@el).html(@template())
    return this