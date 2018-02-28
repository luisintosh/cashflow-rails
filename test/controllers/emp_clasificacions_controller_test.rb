require 'test_helper'

class EmpClasificacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emp_clasificacion = emp_clasificacions(:one)
  end

  test "should get index" do
    get emp_clasificacions_url
    assert_response :success
  end

  test "should get new" do
    get new_emp_clasificacion_url
    assert_response :success
  end

  test "should create emp_clasificacion" do
    assert_difference('EmpClasificacion.count') do
      post emp_clasificacions_url, params: { emp_clasificacion: { nombre: @emp_clasificacion.nombre, tipo_cuenta: @emp_clasificacion.tipo_cuenta, tipo_movimiento: @emp_clasificacion.tipo_movimiento, tipo_subcuenta: @emp_clasificacion.tipo_subcuenta } }
    end

    assert_redirected_to emp_clasificacion_url(EmpClasificacion.last)
  end

  test "should show emp_clasificacion" do
    get emp_clasificacion_url(@emp_clasificacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_emp_clasificacion_url(@emp_clasificacion)
    assert_response :success
  end

  test "should update emp_clasificacion" do
    patch emp_clasificacion_url(@emp_clasificacion), params: { emp_clasificacion: { nombre: @emp_clasificacion.nombre, tipo_cuenta: @emp_clasificacion.tipo_cuenta, tipo_movimiento: @emp_clasificacion.tipo_movimiento, tipo_subcuenta: @emp_clasificacion.tipo_subcuenta } }
    assert_redirected_to emp_clasificacion_url(@emp_clasificacion)
  end

  test "should destroy emp_clasificacion" do
    assert_difference('EmpClasificacion.count', -1) do
      delete emp_clasificacion_url(@emp_clasificacion)
    end

    assert_redirected_to emp_clasificacions_url
  end
end
