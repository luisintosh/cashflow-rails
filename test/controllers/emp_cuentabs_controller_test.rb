require 'test_helper'

class EmpCuentabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emp_cuentab = emp_cuentabs(:one)
  end

  test "should get index" do
    get emp_cuentabs_url
    assert_response :success
  end

  test "should get new" do
    get new_emp_cuentab_url
    assert_response :success
  end

  test "should create emp_cuentab" do
    assert_difference('EmpCuentab.count') do
      post emp_cuentabs_url, params: { emp_cuentab: { moneda: @emp_cuentab.moneda, nombre: @emp_cuentab.nombre, saldo: @emp_cuentab.saldo } }
    end

    assert_redirected_to emp_cuentab_url(EmpCuentab.last)
  end

  test "should show emp_cuentab" do
    get emp_cuentab_url(@emp_cuentab)
    assert_response :success
  end

  test "should get edit" do
    get edit_emp_cuentab_url(@emp_cuentab)
    assert_response :success
  end

  test "should update emp_cuentab" do
    patch emp_cuentab_url(@emp_cuentab), params: { emp_cuentab: { moneda: @emp_cuentab.moneda, nombre: @emp_cuentab.nombre, saldo: @emp_cuentab.saldo } }
    assert_redirected_to emp_cuentab_url(@emp_cuentab)
  end

  test "should destroy emp_cuentab" do
    assert_difference('EmpCuentab.count', -1) do
      delete emp_cuentab_url(@emp_cuentab)
    end

    assert_redirected_to emp_cuentabs_url
  end
end
