require 'test_helper'

class ComComprasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @com_compra = com_compras(:one)
  end

  test "should get index" do
    get com_compras_url
    assert_response :success
  end

  test "should get new" do
    get new_com_compra_url
    assert_response :success
  end

  test "should create com_compra" do
    assert_difference('ComCompra.count') do
      post com_compras_url, params: { com_compra: { ciclo: @com_compra.ciclo, comprobante: @com_compra.comprobante, descuento: @com_compra.descuento, emp_clasificacion_id: @com_compra.emp_clasificacion_id, emp_proveedor_id: @com_compra.emp_proveedor_id, estado: @com_compra.estado, factura: @com_compra.factura, fecha: @com_compra.fecha, tipo_comprobante: @com_compra.tipo_comprobante } }
    end

    assert_redirected_to com_compra_url(ComCompra.last)
  end

  test "should show com_compra" do
    get com_compra_url(@com_compra)
    assert_response :success
  end

  test "should get edit" do
    get edit_com_compra_url(@com_compra)
    assert_response :success
  end

  test "should update com_compra" do
    patch com_compra_url(@com_compra), params: { com_compra: { ciclo: @com_compra.ciclo, comprobante: @com_compra.comprobante, descuento: @com_compra.descuento, emp_clasificacion_id: @com_compra.emp_clasificacion_id, emp_proveedor_id: @com_compra.emp_proveedor_id, estado: @com_compra.estado, factura: @com_compra.factura, fecha: @com_compra.fecha, tipo_comprobante: @com_compra.tipo_comprobante } }
    assert_redirected_to com_compra_url(@com_compra)
  end

  test "should destroy com_compra" do
    assert_difference('ComCompra.count', -1) do
      delete com_compra_url(@com_compra)
    end

    assert_redirected_to com_compras_url
  end
end
