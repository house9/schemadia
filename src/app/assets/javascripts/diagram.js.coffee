class ColumnDefinition
  constructor: (@name = "id", @type = "int", @allowNull = false) ->
    log "constructed"

class TableDefinition
  constructor: (@tableId) ->
    log "init TableDefinition"
    @x = 20
    @y = 20
    @name = "new_table"
    @columns = []
    @columns.push(new ColumnDefinition())

  move: (x, y) ->
    log "TODO: move"

  changeName: (newName) ->
    @name = newName

  addColumn: (column) ->
    @columns.push(column)

  # x: -> return @x
  # y: -> return @y
  # tableId: -> return @tableId

class Workspace
  constructor: ->
    localStorage.name = "schemadia-workspace-storage"
    @tables = []

  persist: ->
    localStorage.workspace = JSON.stringify(@tables)

  find: (id) ->
    table = null
    for t in @tables
      if t.tableId == id
        table = t
        break

    log table
    return table

jQuery =>
  count = 0
  template = Handlebars.compile($('#table-template').html())
  $workspaceUI = $('#workspace-container')
  workspace = new Workspace()

  # *******************************
  log "binding click event"

  $('#new-table-link').click (e) ->
    log 'clicked'
    e.preventDefault()

    t = new TableDefinition("t-#{count}")
    count = count + 1
    workspace.tables.push(t)
    htmlForTable = template(t)

    h = $(htmlForTable).css('position', 'absolute').css('left', t.x).css('top', t.y).css('zIndex', (count + 1000))
    $workspaceUI.append(h)

  # could not get 'on' to work? but 'live' did
  $('.table-name-click').live 'click', (e) ->
    e.preventDefault()
    $link = $(this)
    $link.hide()
    $link.closest('.table-container').find('.table-name-edit-container').show()
    $link.closest('.table-container').find('.table-name-edit-container :input').focus()

  $('.table-name-edit-container :input').live 'keypress', (e) ->
    if e.which == 13
      $input = $(this)
      t = workspace.find($input.closest('.table-container').attr('id'))
      t.changeName($input.val())
      # TODO: workspace.persist()
      $input.closest('.table-name-edit-container').hide()
      $input.closest('.table-container').find('.table-name-click').text($input.val()).show()

  log "done binding"

  # *******************************
  # log "hello"
  # t = new TableDefinition()
  # log t.name
  # t.changeName('users')
  # t.addColumn(new ColumnDefinition('name', 'string'))
  # log t.name
  #
  # tables = []
  # tables.push(t)
  #
  # log "stored"
  #
  # log "get em"
  #
  # fetchTables = JSON.parse(localStorage.workspace)
  # log fetchTables.length
  # log fetchTables[0]