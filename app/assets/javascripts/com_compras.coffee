# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).module 'com_compras', ()->
  # inicializa datatable
  $('#tblComArticulos').DataTable({
    ajax: {
      url: '/com_articulos.json'
      dataSrc: ''
    }
    columns: [
      {data: 'codigo'}
      {data: 'nombre'}
      {data: 'categoria'}
      {data: 'unidad_compra'}
      {data: 'unidad_inventario'}
      {data: 'cantidad_inventario'}
      {data: 'id'}
    ]
    columnDefs: [
      {
        targets: -1
        data: null
        defaultContent: "<button class='btnAgregarItem'><i class='fa fa-check'></i> Agregar</button>"
      }
    ]
  })

  $('#btn-add-com_det_compra').click(()->
    # Crear un nuevo elemento en la lista de artículos
    $('#add-com_det_compra').click()
    # Selecciona el ultimo elemento agregado
    row = $('#com_det_compra tr:last')
    # Buscar valores
    values = $('#modalAgregarArticulo input, #modalAgregarArticulo select')
    # Asignar valores
    $(row).find('')
  )

  # inicializa buscador de articulos select2
  if window.comArticulos
    $('#buscar-producto').select2(
      data: window.comArticulos
      allowClear: true
      width: 'resolve'
    )

  # busca en un arreglo de objetos uno con una ID especifica
  findIdInArray = (arr, id)->
    trueRow = null
    for row in arr
      if row.id = id
        trueRow = row
    trueRow

  # detecta la seleccion de un articulo y lanza el modal
  $('#buscar-producto').on('change', ()->
    val = $('#buscar-producto').val()
    if !!val && parseInt(val) > 0
      articulo = comArticulos.where id: parseInt(val)
      #console.log(articulo)
      if articulo[0]
        articulo = articulo[0]
        window.articuloTemp = articulo

        $('#modalAgregarArticulo').find('.nombre').html(articulo.nombre)
        $('#modalAgregarArticulo').find('.codigo').html(articulo.codigo)
        $('#modalAgregarArticulo').find('.categoria').html(articulo.categoria)
        $('#modalAgregarArticulo').find('.unidad_compra').html(articulo.unidad_compra)
        $('#modalAgregarArticulo').find('.unidad_inventario').html(articulo.unidad_inventario)
        $('#modalAgregarArticulo').find('.cantidad_inventario').html(articulo.cantidad_inventario)
        $('#modalAgregarArticulo').find('.impuestos').html("IVA: #{articulo.iva}%, IEPS: #{articulo.ieps}%")

      $('#modalAgregarArticulo').modal('show')
  )

  # limpia campos en modal
  limpia_modal_inputs = ()->
    $('#cdc_cantidad').val(1)
    $('#cdc_precio').val(0)
    $('#cdc_descuento').val(0)

  # valida el det de compra y lo agrega a la lista
  $('#btn-add-com_det_compra').click( ()->
    val = $('#buscar-producto').val()
    if !!val
      det_articulo = $('form#form-det-articulo')
      validity = det_articulo[0].reportValidity()
      if validity
        $('#buscar-producto').val(-1).trigger('change') # limpia el buscador de articulos
        # guarda los datos del com_det_compra
        window.articuloTemp.cantidad = det_articulo.find('#cdc_cantidad').val()
        window.articuloTemp.precio = det_articulo.find('#cdc_precio').val()
        window.articuloTemp.moneda = det_articulo.find('#cdc_moneda').val()
        window.articuloTemp.locacion = det_articulo.find('#cdc_com_locacion_id').val()
        window.articuloTemp.inventariar = det_articulo.find('#cdc_inventariar').prop('checked')
        window.articuloTemp.descuento = det_articulo.find('#cdc_descuento').val()
        $('#com_det_compra .add_fields').click() # agrega item a la lista
        $('#modalAgregarArticulo').modal('hide')
  )

  # Suma los totales por moneda y los presenta en la tabla de resultados
  suma_compras = ()->
    if window.monedas
      for moneda in window.monedas
        valor = 0.0
        descuento = 0.0
        subtotal = 0.0
        iva = 0.0
        ieps = 0.0
        total = 0.0

        $('#com_det_compra .line-items .nested-fields').each((i,e)->
          row = $(this)
          if row.find('.moneda').val() == moneda
            valor += valorTm = parseFloat(row.find('.cantidad').val()) * parseFloat(row.find('.precio').val())
            descuento += descuentoTm = valorTm * parseFloat(row.find('.descuento').val()) / 100
            subtotal += subtotalTm = valorTm - descuentoTm
            iva += ivaTm = subtotalTm * parseFloat(row.find('.iva').val()) / 100
            ieps += iepsTm = subtotalTm * parseFloat(row.find('.ieps').val()) / 100
            total += totalTm = subtotalTm + ivaTm + iepsTm
        )

        $("#cc_#{moneda}_valor").html("$ #{valor.toFixed(2)}")
        $("#cc_#{moneda}_descuento").html("$ #{descuento.toFixed(2)}")
        $("#cc_#{moneda}_subtotal").html("$ #{subtotal.toFixed(2)}")
        $("#cc_#{moneda}_iva").html("$ #{iva.toFixed(2)}")
        $("#cc_#{moneda}_ieps").html("$ #{ieps.toFixed(2)}")
        $("#cc_#{moneda}_total").html("$ #{total.toFixed(2)}")

  # detecta cuando un articulo es agregado a la lista y le agrega sus detalles
  $('#com_det_compra').on('cocoon:after-insert', (e, item) ->
    item.find('.articulo').val(window.articuloTemp.id)
    item.find('.cantidad').val(window.articuloTemp.cantidad)
    item.find('.precio').val(window.articuloTemp.precio)
    item.find('.moneda').val(window.articuloTemp.moneda)
    item.find('.locacion').val(window.articuloTemp.locacion)
    item.find('.inventariar').prop('checked', window.articuloTemp.inventariar)
    item.find('.iva').val(window.articuloTemp.iva)
    item.find('.ieps').val(window.articuloTemp.ieps)
    item.find('.descuento').val(window.articuloTemp.descuento)
    window.articuloTemp = null
    suma_compras()
  )

  $('#modalAgregarArticulo').on('hidden.bs.modal', ()->
    limpia_modal_inputs()
    $('#buscar-producto').val(-1).trigger('change') # limpia el buscador de articulos
  )

  # suma inicial
  suma_compras()

  # orden de la tabla
  window.data_table.order([0, 'desc']).draw()