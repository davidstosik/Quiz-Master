#= require simplemde.min
$(document).on 'turbolinks:load', ->
  $('.simplemde').each ->
    new SimpleMDE element: this
