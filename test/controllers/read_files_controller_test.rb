require 'test_helper'

class ReadFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @read_file = read_files(:one)
  end

  test "should get index" do
    get read_files_url
    assert_response :success
  end

  test "should get new" do
    get new_read_file_url
    assert_response :success
  end

  test "should create read_file" do
    assert_difference('ReadFile.count') do
      post read_files_url, params: { read_file: { descripcion: @read_file.descripcion, fecha: @read_file.fecha, monto: @read_file.monto, referencia: @read_file.referencia, saldo: @read_file.saldo } }
    end

    assert_redirected_to read_file_url(ReadFile.last)
  end

  test "should show read_file" do
    get read_file_url(@read_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_read_file_url(@read_file)
    assert_response :success
  end

  test "should update read_file" do
    patch read_file_url(@read_file), params: { read_file: { descripcion: @read_file.descripcion, fecha: @read_file.fecha, monto: @read_file.monto, referencia: @read_file.referencia, saldo: @read_file.saldo } }
    assert_redirected_to read_file_url(@read_file)
  end

  test "should destroy read_file" do
    assert_difference('ReadFile.count', -1) do
      delete read_file_url(@read_file)
    end

    assert_redirected_to read_files_url
  end
end
