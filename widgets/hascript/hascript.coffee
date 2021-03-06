class Dashing.Hascript extends Dashing.ClickableWidget
  constructor: ->
    super

  state = 'off'
    
  @accessor 'icon',
    get: -> @['icon'] ? 'tag'
    set: Batman.Property.defaultAccessor.set

  @accessor 'icon-style',
    get: -> if state == 'on' then 'icon-active' else 'icon-inactive'
    set: Batman.Property.defaultAccessor.set

  ready: ->
    if @get('bgcolor')
      $(@node).css("background-color", @get('bgcolor'))
    else
      $(@node).css("background-color", "#444")

  turnOff: =>
    state = 'off'
    @set 'icon-style', 'icon-inactive'
  
  postScene: ->
    $.post '/homeassistant/script',
      widgetId: @get('id'),

  onClick: (event) ->
    @postScene()
    state = 'on'
    @set 'icon-style', 'icon-active'
    @_timeout = setTimeout(@turnOff, @['ontime'] ? 1000)
