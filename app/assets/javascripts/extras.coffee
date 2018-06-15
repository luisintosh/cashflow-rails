# Ejecuta la funcion cuando el body tiene el id indicado
jQuery.fn.extend({
  module: (selector, func)->
    $(document).on 'turbolinks:load', ()->
      if $(selector).length
        func()
})

# Select all text in any field on focus for easy re-entry. Delay sightly to allow focus to "stick" before selecting.
focusedElement = undefined
$(document).on 'focus', 'input[type=text], input[type=number]', ->
  if focusedElement == this
    return
  #already focused, return so user can now place cursor at specific point in input.
  focusedElement = this
  setTimeout (->
    focusedElement.select()
    return
  ), 50
  return

# Convierte las letras en mayuscula o minuscula segun sea el caso
$(document).on 'keyup', '.uppercase', (e) ->
  @value = @value.toUpperCase()
  return
$(document).on 'keyup', '.lowercase', (e) ->
  @value = @value.toLowerCase()
  return

# Asigna un valor 0 a tods los inputs de tipo number si tienen la clase required
$('input.required[type="number"]').on 'change', ()->
  unless !!this.value
    if this.step == 'any'
      this.value = '0.0'
    else
      this.value = 0

# Convierte todos los elementos tipo select a un selector más avanzado con filtros
$(document).on 'turbolinks:load', ()->
  $('select.select:not(.noselect2)').select2()

# Busqueda where en arreglos de objetos
Array::where = (query) ->
  return [] if typeof query isnt "object"
  hit = Object.keys(query).length
  @filter (item) ->
    match = 0
    for key, val of query
      match += 1 if item[key] is val
    if match is hit then true else false

# Desactiva la capacidad de mostrar la lista de un select
$(document).on('mousedown', '.readonly-select', (e)->
  e.preventDefault()
  this.blur()
  window.focus()
)

###*
# Formatea un número a una cantidad monetaria separando grupos de 3 números por comas
# @param number
# @returns {string}
###
window.numberToCurrency = (number) ->
  return if typeof number != 'number'
  number = parseInt(number).toFixed(2)
  number = number.toString()
  number = number.split('').reverse().join('')
  number = number.split('.')
  number[1] = number[1].match(/.{1,3}/g).join(',')
  number = number.join('.')
  number = number.split('').reverse().join('')
  number