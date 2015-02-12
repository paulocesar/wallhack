jsRoot = @

{ _, ace, Backbone, Wallhack } = jsRoot

class Editor extends Backbone.View
    constructor: (options) ->
        _.extend(@, options)

        if !@logger
            throw new Error("the 'logger' is missing")

        @editor = ace.edit(@editor)
        #@editor.setTheme("ace/theme/twilight")
        @editor.getSession().setMode("ace/mode/sql")

        options.events = {
            'click button.execute': 'execute'
        }

        super

    execute: () -> Wallhack.execute(@getQuery(), @onExecDone)

    setQuery: (sql) -> @editor.getSession().setValue(sql)
    getQuery: (sql) -> @editor.getSession().getValue(sql)

    onExecDone: (error, lines) =>
        @logger.setData(error, lines)
        @logger.render()

Wallhack.components.Editor = Editor
