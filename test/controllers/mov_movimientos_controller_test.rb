require 'test_helper'

class MovMovimientosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mov_movimiento = mov_movimientos(:one)
  end

  test "should get index" do
    get mov_movimientos_url
    assert_response :success
  end

  test "should get new" do
    get new_mov_movimiento_url
    assert_response :success
  end

  test "should create mov_movimiento" do
    assert_difference('MovMovimiento.count') do
      post mov_movimientos_url, params: { mov_movimiento: { ciclo: @mov_movimiento.ciclo, comprobante: @mov_movimiento.comprobante, concepto: @mov_movimiento.concepto, emp_clasificacion_id: @mov_movimiento.emp_clasificacion_id, emp_cliente_id: @mov_movimiento.emp_cliente_id, emp_cuentab_id: @mov_movimiento.emp_cuentab_id, emp_locacion_id: @mov_movimiento.emp_locacion_id, emp_proveedor_id: @mov_movimiento.emp_proveedor_id, factura: @mov_movimiento.factura, fecha: @mov_movimiento.fecha, hoja: @mov_movimiento.hoja, ieps: @mov_movimiento.ieps, iva: @mov_movimiento.iva, subtotal: @mov_movimiento.subtotal, tipo_comprobante: @mov_movimiento.tipo_comprobante, tipo_movimiento: @mov_movimiento.tipo_movimiento, total: @mov_movimiento.total } }
    end

    assert_redirected_to mov_movimiento_url(MovMovimiento.last)
  end

  test "should show mov_movimiento" do
    get mov_movimiento_url(@mov_movimiento)
    assert_response :success
  end

  test "should get edit" do
    get edit_mov_movimiento_url(@mov_movimiento)
    assert_response :success
  end

  test "should update mov_movimiento" do
    patch mov_movimiento_url(@mov_movimiento), params: { mov_movimiento: { ciclo: @mov_movimiento.ciclo, comprobante: @mov_movimiento.comprobante, concepto: @mov_movimiento.concepto, emp_clasificacion_id: @mov_movimiento.emp_clasificacion_id, emp_cliente_id: @mov_movimiento.emp_cliente_id, emp_cuentab_id: @mov_movimiento.emp_cuentab_id, emp_locacion_id: @mov_movimiento.emp_locacion_id, emp_proveedor_id: @mov_movimiento.emp_proveedor_id, factura: @mov_movimiento.factura, fecha: @mov_movimiento.fecha, hoja: @mov_movimiento.hoja, ieps: @mov_movimiento.ieps, iva: @mov_movimiento.iva, subtotal: @mov_movimiento.subtotal, tipo_comprobante: @mov_movimiento.tipo_comprobante, tipo_movimiento: @mov_movimiento.tipo_movimiento, total: @mov_movimiento.total } }
    assert_redirected_to mov_movimiento_url(@mov_movimiento)
  end

  test "should destroy mov_movimiento" do
    assert_difference('MovMovimiento.count', -1) do
      delete mov_movimiento_url(@mov_movimiento)
    end

    assert_redirected_to mov_movimientos_url
  end
end
