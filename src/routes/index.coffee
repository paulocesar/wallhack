_ = require('underscore')
express = require('express')
router = express.Router()

#TODO: it's not beautiful, need love
class WallhackTemplate
    constructor: (@db) ->

    exec: (query, cb) -> @db.execute(query, cb)

    list: (cb) -> @exec("SELECT * FROM WallhackTemplate", cb)

    insert: (data, cb) ->
        @exec("""
            INSERT INTO WallhackTemplate (name, template)
            VALUES('#{data.name}', '#{data.template}')
            SELECT * FROM WallhackTemplate WHERE name = '#{data.name}'
        """, cb)

    update: (data, cb) ->
        @exec("""
            UPDATE WallhackTemplate
            SET name = '#{data.name}', template = '#{data.template}'
            WHERE id = #{data.id}
            SELECT * FROM WallhackTemplate WHERE name = '#{data.name}'
        """, cb)

    delete: (data, cb) ->
        @exec("DELETE FROM WallhackTemplate WHERE id = #{data.id}; SELECT 1", cb)

router.get '/', (req, res) ->
    db = req.db

    res.render('index', {
        title: 'Wallhack'
    })

router.post '/execute', (req, res) ->
    req.db.execute(req.json().query, res.sendDataOrError)

router.post '/scripts/list', (req, res) ->
    w = new WallhackTemplate(req.db)
    w.list(res.sendDataOrError)

router.post '/scripts/create', (req, res) ->
    w = new WallhackTemplate(req.db)
    w.insert(req.json(), res.sendDataOrError)

router.post '/scripts/update', (req, res) ->
    w = new WallhackTemplate(req.db)
    w.update(req.json(), res.sendDataOrError)

router.post '/scripts/delete', (req, res) ->
    w = new WallhackTemplate(req.db)
    w.delete(req.json(), res.sendDataOrError)

module.exports = router
