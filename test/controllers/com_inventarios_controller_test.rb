require 'test_helper'

class ComInventariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @com_inventario = com_inventarios(:one)
  end

  test "should get index" do
    get com_inventarios_url
    assert_response :success
  end

  test "should get new" do
    get new_com_inventario_url
    assert_response :success
  end

  test "should create com_inventario" do
    assert_difference('ComInventario.count') do
      post com_inventarios_url, params: { com_inventario: { com_articulo_id: @com_inventario.com_articulo_id, emp_locacion_id: @com_inventario.emp_locacion_id, stock: @com_inventario.stock, stock_min: @com_inventario.stock_min } }
    end

    assert_redirected_to com_inventario_url(ComInventario.last)
  end

  test "should show com_inventario" do
    get com_inventario_url(@com_inventario)
    assert_response :success
  end

  test "should get edit" do
    get edit_com_inventario_url(@com_inventario)
    assert_response :success
  end

  test "should update com_inventario" do
    patch com_inventario_url(@com_inventario), params: { com_inventario: { com_articulo_id: @com_inventario.com_articulo_id, emp_locacion_id: @com_inventario.emp_locacion_id, stock: @com_inventario.stock, stock_min: @com_inventario.stock_min } }
    assert_redirected_to com_inventario_url(@com_inventario)
  end

  test "should destroy com_inventario" do
    assert_difference('ComInventario.count', -1) do
      delete com_inventario_url(@com_inventario)
    end

    assert_redirected_to com_inventarios_url
  end
end
