jsRoot = @

{ _, ace, Backbone, Wallhack } = jsRoot

class Logger extends Backbone.View
    setData: (@error, @lines) ->
        @lines ?= []

    render: () ->
        if @error
            return @$el.html(@error.message)

        @$el.html(Wallhack.tpls.response({ @lines }))

Wallhack.components.Logger = Logger
