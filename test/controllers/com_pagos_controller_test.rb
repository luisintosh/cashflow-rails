require 'test_helper'

class ComPagosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @com_pago = com_pagos(:one)
  end

  test "should get index" do
    get com_pagos_url
    assert_response :success
  end

  test "should get new" do
    get new_com_pago_url
    assert_response :success
  end

  test "should create com_pago" do
    assert_difference('ComPago.count') do
      post com_pagos_url, params: { com_pago: { com_compra_id: @com_pago.com_compra_id, monto: @com_pago.monto, mov_movimiento_id: @com_pago.mov_movimiento_id, tipo_pago: @com_pago.tipo_pago } }
    end

    assert_redirected_to com_pago_url(ComPago.last)
  end

  test "should show com_pago" do
    get com_pago_url(@com_pago)
    assert_response :success
  end

  test "should get edit" do
    get edit_com_pago_url(@com_pago)
    assert_response :success
  end

  test "should update com_pago" do
    patch com_pago_url(@com_pago), params: { com_pago: { com_compra_id: @com_pago.com_compra_id, monto: @com_pago.monto, mov_movimiento_id: @com_pago.mov_movimiento_id, tipo_pago: @com_pago.tipo_pago } }
    assert_redirected_to com_pago_url(@com_pago)
  end

  test "should destroy com_pago" do
    assert_difference('ComPago.count', -1) do
      delete com_pago_url(@com_pago)
    end

    assert_redirected_to com_pagos_url
  end
end
