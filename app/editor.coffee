jsRoot = @

{ _, ace, Backbone, Wallhack } = jsRoot

class Response extends Backbone.View
    setData: (@error, @lines) ->
        @lines ?= []

    render: () ->
        if @error
            return @$el.html(@error.message)

        @$el.html(Wallhack.tpls.response({ @lines }))

class Editor extends Backbone.View
    constructor: (options) ->
        _.extend(@, options)

        @editor = ace.edit(@editor)
        #@editor.setTheme("ace/theme/twilight")
        @editor.getSession().setMode("ace/mode/sql")

        options.events = {
            'click button.execute': 'execute'
        }

        @response = new Response({
            el: @responseEl
            template: Wallhack.tpls.reponse
        })

        super

    execute: () -> Wallhack.execute(@getQuery(), @onExecDone)

    setQuery: (sql) -> @editor.getSession().setValue(sql)
    getQuery: (sql) -> @editor.getSession().getValue(sql)

    onExecDone: (error, lines) =>
        @response.setData(error, lines)
        @response.render()

ed = new Editor({
    el: '#editor'
    editor: 'sqlEditor',
    responseEl: '#sqlResponse'
})

ed.setQuery("SELECT TOP 10 * FROM tblMenu ORDER BY UtcLastModifiedOn DESC")

Wallhack.components.Editor = Editor
