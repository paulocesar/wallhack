_ = require('underscore')
express = require('express')
router = express.Router()

# GET home page.
router.get '/', (req, res) ->
    db = req.db

    res.render('index', {
        title: 'Wallhack'
    })

router.post '/execute', (req, res) ->
    q = JSON.parse(req.body.data).query
    req.db.execute(q, (err, data) ->
        return res.send({ status: false, data: JSON.stringify(err) }) if err?
        res.json({ success: true, data: JSON.stringify(data) })
    )


module.exports = router
