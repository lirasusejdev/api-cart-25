Rails.application.routes.draw do
  # Exibir o carrinho
  get "/cart", to: "carts#show"

  # Adicionar ou atualizar um produto no carrinho
  post "/cart/items", to: "carts#add_item"

  # Remover um produto do carrinho
  delete "/cart/items/:product_id", to: "carts#remove_product"
end
