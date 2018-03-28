require 'test_helper'

class ComArticulosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @com_articulo = com_articulos(:one)
  end

  test "should get index" do
    get com_articulos_url
    assert_response :success
  end

  test "should get new" do
    get new_com_articulo_url
    assert_response :success
  end

  test "should create com_articulo" do
    assert_difference('ComArticulo.count') do
      post com_articulos_url, params: { com_articulo: { cantidad_inventario: @com_articulo.cantidad_inventario, categoria: @com_articulo.categoria, codigo: @com_articulo.codigo, moneda: @com_articulo.moneda, nombre: @com_articulo.nombre, p_ieps: @com_articulo.p_ieps, p_iva: @com_articulo.p_iva, precio_compra: @com_articulo.precio_compra, unidad_compra: @com_articulo.unidad_compra, unidad_inventario: @com_articulo.unidad_inventario } }
    end

    assert_redirected_to com_articulo_url(ComArticulo.last)
  end

  test "should show com_articulo" do
    get com_articulo_url(@com_articulo)
    assert_response :success
  end

  test "should get edit" do
    get edit_com_articulo_url(@com_articulo)
    assert_response :success
  end

  test "should update com_articulo" do
    patch com_articulo_url(@com_articulo), params: { com_articulo: { cantidad_inventario: @com_articulo.cantidad_inventario, categoria: @com_articulo.categoria, codigo: @com_articulo.codigo, moneda: @com_articulo.moneda, nombre: @com_articulo.nombre, p_ieps: @com_articulo.p_ieps, p_iva: @com_articulo.p_iva, precio_compra: @com_articulo.precio_compra, unidad_compra: @com_articulo.unidad_compra, unidad_inventario: @com_articulo.unidad_inventario } }
    assert_redirected_to com_articulo_url(@com_articulo)
  end

  test "should destroy com_articulo" do
    assert_difference('ComArticulo.count', -1) do
      delete com_articulo_url(@com_articulo)
    end

    assert_redirected_to com_articulos_url
  end
end
