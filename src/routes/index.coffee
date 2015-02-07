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
    req.db.execute(req.json().query, res.sendDataOrError)

module.exports = router
