# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).module '#mov_movimientos', ()->

  # Calcular total
  calcular_total = ()->
    subtotal = parseFloat($('#mov_movimiento_subtotal').val()) or 0.0
    iva = parseFloat($('#mov_movimiento_iva').val()) or 0.0
    ieps = parseFloat($('#mov_movimiento_ieps').val()) or 0.0
    subtotal + iva + ieps

  validar_total = ()->
    total = parseFloat($('#mov_movimiento_total').val()) or 0.0
    total_calculado = calcular_total()
    if total == total_calculado
      $('#mov_movimiento_total').removeClass('text-danger')
    else
      $('#mov_movimiento_total').addClass('text-danger')
    $('#mov_movimiento_total').attr( {min: total_calculado} )

  # subtotal / iva / ieps
  $(document).on('change input', '#mov_movimiento_subtotal, #mov_movimiento_iva, #mov_movimiento_ieps', ()->
    $('#mov_movimiento_total').val( calcular_total() )
    validar_total()
  )

  $(document).on('change input', '#mov_movimiento_total', ()->
    validar_total()
  )

  $(document).on('click', '#calcular-iva', (e)->
    e.preventDefault()
    subtotal = parseFloat($('#mov_movimiento_subtotal').val()) or 0.0
    iva = $('#mov_movimiento_iva')
    iva.val( subtotal * 0.16 )
    iva.change()
  )

  $(document).on('click', '#calcular-ieps-base-iva', (e)->
    e.preventDefault()
    subtotal = parseFloat($('#mov_movimiento_subtotal').val()) or null;
    iva = parseFloat($('#mov_movimiento_iva').val()) or null;

    if !subtotal or subtotal == 0
      return alert('Debes definir un valor en Subtotal')
    if !iva or iva == 0
      return alert('Debes definir un valor en IVA')
    # calcula valores
    ieps = iva / 0.16 - subtotal
    total = subtotal + ieps + iva
    # asigna valores
    $('#mov_movimiento_ieps').val(ieps)
    $('#mov_movimiento_total').val(total)
  )

  $('#save-add').click( ()->
    $('#save_and_add').val(1)
    $(this).closest('form').submit()
  )

  # modal para nuevo cliente o proveedor
  window.newFormCallback = (data, form_id)->
    if form_id == 'new_emp_cliente'
      selector = $('#mov_movimiento_emp_cliente_id')
      selector.append("<option value='#{data.id}'>#{data.nombre} #{data.apellidos}</option>")
    else if form_id == 'new_emp_proveedor'
      selector = $('#mov_movimiento_emp_proveedor_id')
      selector.append("<option value='#{data.id}'>#{data.empresa}</option>")

    selector.val(data.id)
    selector.change()
