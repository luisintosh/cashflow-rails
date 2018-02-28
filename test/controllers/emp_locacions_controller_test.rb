require 'test_helper'

class EmpLocacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emp_locacion = emp_locacions(:one)
  end

  test "should get index" do
    get emp_locacions_url
    assert_response :success
  end

  test "should get new" do
    get new_emp_locacion_url
    assert_response :success
  end

  test "should create emp_locacion" do
    assert_difference('EmpLocacion.count') do
      post emp_locacions_url, params: { emp_locacion: { direccion: @emp_locacion.direccion, nombre: @emp_locacion.nombre } }
    end

    assert_redirected_to emp_locacion_url(EmpLocacion.last)
  end

  test "should show emp_locacion" do
    get emp_locacion_url(@emp_locacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_emp_locacion_url(@emp_locacion)
    assert_response :success
  end

  test "should update emp_locacion" do
    patch emp_locacion_url(@emp_locacion), params: { emp_locacion: { direccion: @emp_locacion.direccion, nombre: @emp_locacion.nombre } }
    assert_redirected_to emp_locacion_url(@emp_locacion)
  end

  test "should destroy emp_locacion" do
    assert_difference('EmpLocacion.count', -1) do
      delete emp_locacion_url(@emp_locacion)
    end

    assert_redirected_to emp_locacions_url
  end
end
