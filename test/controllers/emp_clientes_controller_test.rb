require 'test_helper'

class EmpClientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emp_cliente = emp_clientes(:one)
  end

  test "should get index" do
    get emp_clientes_url
    assert_response :success
  end

  test "should get new" do
    get new_emp_cliente_url
    assert_response :success
  end

  test "should create emp_cliente" do
    assert_difference('EmpCliente.count') do
      post emp_clientes_url, params: { emp_cliente: { apellidos: @emp_cliente.apellidos, emp_perfil_id: @emp_cliente.emp_perfil_id, nombre: @emp_cliente.nombre, saldo: @emp_cliente.saldo, saldo_max: @emp_cliente.saldo_max } }
    end

    assert_redirected_to emp_cliente_url(EmpCliente.last)
  end

  test "should show emp_cliente" do
    get emp_cliente_url(@emp_cliente)
    assert_response :success
  end

  test "should get edit" do
    get edit_emp_cliente_url(@emp_cliente)
    assert_response :success
  end

  test "should update emp_cliente" do
    patch emp_cliente_url(@emp_cliente), params: { emp_cliente: { apellidos: @emp_cliente.apellidos, emp_perfil_id: @emp_cliente.emp_perfil_id, nombre: @emp_cliente.nombre, saldo: @emp_cliente.saldo, saldo_max: @emp_cliente.saldo_max } }
    assert_redirected_to emp_cliente_url(@emp_cliente)
  end

  test "should destroy emp_cliente" do
    assert_difference('EmpCliente.count', -1) do
      delete emp_cliente_url(@emp_cliente)
    end

    assert_redirected_to emp_clientes_url
  end
end
