describe Spree::Product, type: :model do
  before do
    @store = create(:store)
    @product = create(:product, stores: [@store])
    @product2 = create(:product, slug: 'something else')
  end

  it 'correctly find products by store' do
    products_by_store = Spree::Product.by_store(@store)
    expect(products_by_store).to include(@product)
    expect(products_by_store).not_to include(@product2)
  end
end
