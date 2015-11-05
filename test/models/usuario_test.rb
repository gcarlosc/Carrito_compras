require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "debe crear un usuario" do
    u = Usuario.new(username: "Giancarlo", email: "gcarlo@mail.com", password: "123456789")
    assert u.save
  end

  test "debe crear un usuario sin email" do
    u = Usuario.new(username: "Giancarlo", password: "123456789")
    assert u.save
  end

end
