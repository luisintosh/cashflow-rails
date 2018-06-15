# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).module '#panel', ()->
  # =========================================================================
  # FLOT
  # =========================================================================

  initFlotMovimientos = ()->
    o = this
    chart = $('#flot-visitors')
    # Elements check
    if !$.isFunction($.fn.plot) or chart.length == 0
      return
    # List of mxn
    dataListMXN = []
    for dk, dv of window.mov_ingreso_mxn
      dataListMXN.push [dk, dv]
    console.log dataListMXN
    # Chart data
    data = [
      {
        label: 'Ingresos MXN'
        data: dataListMXN
        last: true
      }
      {
        label: 'Ingresos USD'
        data: [[]]
        last: true
      }
      {
        label: 'Ingresos EUR'
        data: [[]]
        last: true
      }
    ]
    # Chart options
    labelColor = chart.css('color')
    options = 
      colors: chart.data('color').split(',')
      series:
        shadowSize: 0
        lines:
          show: true
          lineWidth: false
          fill: true
        curvedLines:
          apply: true
          active: true
          monotonicFit: false
      legend: container: $('#flot-visitors-legend')
      xaxis:
        mode: 'time'
        timeformat: '%d %b'
        font: color: labelColor
      yaxis: font: color: labelColor
      grid:
        borderWidth: 0
        color: labelColor
        hoverable: true
    chart.width '100%'
    # Create chart
    plot = $.plot(chart, data, options)
    # Hover function
    tip = null
    previousPoint = null
    chart.bind 'plothover', (event, pos, item) ->
      if item
        if previousPoint != item.dataIndex
          previousPoint = item.dataIndex
          x = item.datapoint[0]
          y = item.datapoint[1]
          tipLabel = '<strong>' + $(this).data('title') + '</strong>'
          tipContent = Math.round(y) + ' ' + item.series.label.toLowerCase() + ' on ' + moment(x).format('dddd')
          if tip != undefined
            $(tip).popover 'destroy'
          tip = $('<div></div>').appendTo('body').css(
            left: item.pageX
            top: item.pageY - 5
            position: 'absolute'    )
          tip.popover(
            html: true
            title: tipLabel
            content: tipContent
            placement: 'top').popover('show')
      else
        if tip != undefined
          $(tip).popover('hide')
        previousPoint = null

  initFlotMovimientos()