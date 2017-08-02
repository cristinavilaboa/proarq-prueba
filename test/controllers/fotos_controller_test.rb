require 'test_helper'

class FotosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @foto = fotos(:one)
	sign_in users(:one)
  end

  test "should get new" do
    get new_proyecto_foto_url(@foto.proyecto_id)
    assert_response :success
  end

  test "should create foto" do
    assert_difference('Foto.count') do
      post proyecto_fotos_url(@foto.proyecto_id), params: { foto: { descripcion: @foto.descripcion, src: @foto.src, public_id: @foto.public_id} }
    end

    assert_redirected_to proyecto_url(@foto.proyecto_id)
  end

  test "should destroy foto" do
    assert_difference('Foto.count', -1) do
      delete proyecto_foto_url(@foto.proyecto_id, @foto.id)
    end

    assert_redirected_to proyecto_url(@foto.proyecto_id)
  end
end
