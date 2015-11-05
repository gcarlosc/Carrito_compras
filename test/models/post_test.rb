require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "debe poder crear un post" do
    post = Post.create(titulo: "post 1", contenido: "mi contenido 1")
    assert post.save
  end

  test "debe actualizar un post" do
    post = posts(:primer_articulo)
    assert post.update(titulo: "titulo nuevo", contenido: "nuevo contenido")
  end

  test "debe encontrar un post por su id" do
    post_id = posts(:primer_articulo).id
    post = Post.find(post_id)
    assert_equal post, posts(:primer_articulo), "no encontro el registro" 
  end

  #TDD - se busca pruebas con errores
  #se crea un post sin titulo y con post.invalid? dara true
  #por lo tanto la prueba pasara indicando q no hya ningun error
  test "no debe crear un post sin titulo" do
    post = Post.new
    assert post.invalid?, "el post debe ser invalido"
  end


end
