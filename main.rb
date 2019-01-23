require './dependencies'

require './interpreter/interpreter'
require './models/_models'
require './storage/_stores'

require './config'
require './application'

app = Application.new
app.run
