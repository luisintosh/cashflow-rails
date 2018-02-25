require 'test_helper'

class EmpProveedorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emp_proveedor = emp_proveedors(:one)
  end

  test "should get index" do
    get emp_proveedors_url
    assert_response :success
  end

  test "should get new" do
    get new_emp_proveedor_url
    assert_response :success
  end

  test "should create emp_proveedor" do
    assert_difference('EmpProveedor.count') do
      post emp_proveedors_url, params: { emp_proveedor: { emp_perfil_id: @emp_proveedor.emp_perfil_id, empresa: @emp_proveedor.empresa, saldo: @emp_proveedor.saldo, saldo_max: @emp_proveedor.saldo_max } }
    end

    assert_redirected_to emp_proveedor_url(EmpProveedor.last)
  end

  test "should show emp_proveedor" do
    get emp_proveedor_url(@emp_proveedor)
    assert_response :success
  end

  test "should get edit" do
    get edit_emp_proveedor_url(@emp_proveedor)
    assert_response :success
  end

  test "should update emp_proveedor" do
    patch emp_proveedor_url(@emp_proveedor), params: { emp_proveedor: { emp_perfil_id: @emp_proveedor.emp_perfil_id, empresa: @emp_proveedor.empresa, saldo: @emp_proveedor.saldo, saldo_max: @emp_proveedor.saldo_max } }
    assert_redirected_to emp_proveedor_url(@emp_proveedor)
  end

  test "should destroy emp_proveedor" do
    assert_difference('EmpProveedor.count', -1) do
      delete emp_proveedor_url(@emp_proveedor)
    end

    assert_redirected_to emp_proveedors_url
  end
end
