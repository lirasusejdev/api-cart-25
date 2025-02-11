class CartsController < ApplicationController
  before_action :set_cart

  # Adicionar ou atualizar a quantidade de um produto no carrinho
  def add_item
    product = Product.find_by(id: params[:product_id]) # Usar find_by para evitar exceções

    if product.nil?
      render json: { error: 'Produto não encontrado' }, status: :not_found
      return
    end

    cart_item = @cart.cart_items.find_by(product: product)

    if cart_item
      # Atualiza a quantidade do produto existente
      cart_item.update!(quantity: cart_item.quantity + params[:quantity].to_i)
    else
      # Cria novo item no carrinho
      @cart.cart_items.create!(
        product: product,
        quantity: params[:quantity],
        total_price: product.unit_price * params[:quantity].to_i
      )
    end

    render json: cart_response, status: :ok
  end

  # Exibir o carrinho
  def show
    render json: cart_response, status: :ok
  end

  # Remover um produto do carrinho
  def remove_product
    cart_item = @cart.cart_items.find_by(product_id: params[:product_id])

    if cart_item
      cart_item.destroy
      render json: cart_response, status: :ok
    else
      render json: { error: 'Produto não encontrado no carrinho' }, status: :not_found
    end
  end

  private

  # Configurar o carrinho, ou criar um novo se não existir
  def set_cart
    @cart = Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] ||= @cart.id
  end

  # Gerar o payload de resposta do carrinho
  def cart_response
    {
      id: @cart.id,
      products: @cart.cart_items.includes(:product).map { |item| product_payload(item) },
      total_price: @cart.total_price
    }
  end

  # Gerar o payload do produto
  def product_payload(cart_item)
    {
      id: cart_item.product.id,
      name: cart_item.product.name,
      quantity: cart_item.quantity,
      unit_price: cart_item.product.unit_price,
      total_price: cart_item.total_price
    }
  end
end
