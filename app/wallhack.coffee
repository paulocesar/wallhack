jsRoot = @

{ $, _ } = jsRoot


Wallhack = {
    VERSION: '0.0.1'

    container: $('#wallhack')

    tpls: {}

    components: {}

    init: (callback) ->
        $('.tpl').each(() ->
            $el = $(@)
            name = $el.attr('id').replace 'tpl-', ''
            Wallhack.tpls[name] = _.template($el.html())
        )

        callback()

    render: (name) ->
        data = @tpls[name]

        unless data?
            throw new Error("Cannot find '#{name}' template screen")

        @container.html(data)

    execute: (query, callback) -> Wallhack.post 'execute', { query }, callback

    post: (action, data, callback) ->
        $.post "/#{action}", {data: JSON.stringify(data)}, (raw) =>
            res = @evalResponse(raw.data)

            unless raw.success
                return callback(res)

            callback(null, res)

    evalResponse: (response) -> ( new Function("return #{response}") )()
}

jsRoot.Wallhack = Wallhack
