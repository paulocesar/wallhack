jsRoot = @

{ Wallhack } = jsRoot
{ Editor, Logger } = Wallhack.components
tpls = Wallhack.tpls

Wallhack.init(() ->
    Wallhack.render('index')

    ed = new Editor({
        el: '#editor'
        editor: 'sqlEditor'
        logger: new Logger({ el: '#sqlResponse', template: tpls.reponse })
    })

    ed.setQuery("SELECT TOP 10 * FROM tblMenu ORDER BY UtcLastModifiedOn DESC")
)
