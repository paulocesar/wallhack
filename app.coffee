express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
bodyParser = require('body-parser')
cookieParser = require('cookie-parser')
session = require('cookie-session')

config = require('./config')
MsSql = require('./src/adapters/mssql')
msSql = new MsSql(config.mssql)
msSql.connect(() -> console.log('connected'))

routes = require('./src/routes/index')

app = express()

# view engine setup
app.set('views', path.join(__dirname, 'src', 'views'))
app.set('view engine', 'ejs')

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(session({ keys: ['kasbsa9da&gd', 'jnasd8yabyb'] }))
app.use(express.static(path.join(__dirname, 'src', 'public')))

#add db and default in middleware
app.use((req, res, next) ->
    req.db = msSql

    req.json = () -> JSON.parse(req.body.data)

    res.sendDataOrError = (err, data) ->
        return res.send({ status: false, data: JSON.stringify(err) }) if err?
        res.json({ success: true, data: JSON.stringify(data) })


    next()
)

app.use('/', routes)

# catch 404 and forward to error handler
app.use((req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next(err)
)

# error handlers

# development error handler
# will print stacktrace
if app.get('env') == 'development'
    app.use((err, req, res, next) ->
        res.status(err.status || 500)
        res.render('error', {
            message: err.message
            error: err
        })
    )


# production error handler
# no stacktraces leaked to user
app.use((err, req, res, next) ->
    res.status(err.status || 500)
    res.render('error', {
        message: err.message
        error: {}
    })
)


module.exports = app
