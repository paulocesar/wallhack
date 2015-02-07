_ = require('underscore')
A = require('async')
Connection = require('tedious').Connection
Request = require('tedious').Request
Adapter = require('./adapter')

class Mssql extends Adapter
    constructor: (@config) -> super()

    connect: (callback) ->
        @connection = new Connection({
            server: @config.host
            userName: @config.user
            password: @config.password
            options: {
                database: @config.database
            }
        })

        @connection.on('connect', callback)

    close: () -> @connection.close()

    execute: (query, callback) ->
        results = []

        req = new Request(query, (err, rowCount) =>
            return callback(err) if (err?)

            callback(null, results)
        )

        req.on('row', (cols) ->
            row = {}

            cols.forEach( (c) ->
                row[c.metadata.colName] = c.value
            )

            results.push(row)
        )

        req.on('done', () -> callback(null, result))

        @connection.execSql(req)


module.exports = Mssql
