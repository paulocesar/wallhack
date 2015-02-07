_ = require('underscore')
A = require('async')
mysql = require('mysql')
Adapter = require('./adapter')

class Mysql extends Adapter
    constructor: (@config) -> super()

    connect: (callback) ->
        @conn = mysql.createConnection(@config)
        @conn.connect((err) -> callback(err))

    close: () -> @conn.end()

    execute: (query, callback) ->
        @conn.query(query, (err, @rows, @fields) =>
            return callback(err) if (err?)
            callback( null, @rows)
        )

module.exports = Mysql
