$(document).on('submit', '.modal-new-form form', (e)->
  e.preventDefault()
  # enviando form
  $.post("#{this.action}.json", $(this).serialize(), (data)->
    # form enviada
    newFormCallback(data)
  )

  $('.modal-new-form').modal('hide')
)