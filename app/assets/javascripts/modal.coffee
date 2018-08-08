$(document).on('submit', '.modal-new-form form', (e)->
  e.preventDefault()
  # reseteando campos
  #$(this).find('input, select').not('inpu[name="utf8"], input[name="authenticity_token"]').val('')
  # enviando form
  $.ajax(
    type: 'POST'
    url: "#{this.action}.json"
    data: $(this).serialize()
    success: (data)->
      # form enviada
      newFormCallback(data, e.target.id)
    error: (data)->
      # form enviada
      alert("Error al guardar el artículo: #{data.responseText}")
  )

  $('.modal-new-form').modal('hide')
)