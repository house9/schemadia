class ColumnDefinition
  constructor: (@name = "id", @type = "int", @allowNull = false) ->
    log "constructed"

class TableDefinition
  constructor: ->
    log "init TableDefinition"
    @x = 0
    @y = 0
    @name = "new_table"
    @columns = []
    @columns.push(new ColumnDefinition())

  move: (x, y) ->
    log "TODO: move"

  changeName: (newName) ->
    @name = newName

  addColumn: (column) ->
    @columns.push(column)

# *******************************
log "hello"
t = new TableDefinition()
log t.name
t.changeName('users')
t.addColumn(new ColumnDefinition('name', 'string'))
log t.name

tables = []
tables.push(t)
localStorage.name = "schemadia-storage"
localStorage.workspace = JSON.stringify(tables)

log "stored"

log "get em"

fetchTables = JSON.parse(localStorage.workspace)
log fetchTables.length
log fetchTables[0]