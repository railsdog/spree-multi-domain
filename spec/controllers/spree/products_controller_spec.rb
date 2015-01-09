describe Spree::ProductsController, type: :model do
  let!(:product) { create(:product) }

  describe '#show to a product without any stores' do
    let!(:store) { create(:store) }

    it 'returns 404' do
      spree_get :show, id: product.to_param
      expect(response.response_code).to be(404)
    end
  end

  # Regression test for #75
  describe '#show to a product in the wrong store' do
    let!(:store_1) { create(:store) }
    let!(:store_2) { create(:store) }

    before do
      product.stores << store_1
    end

    it 'returns 404' do
      allow(subject).to receive(:current_store).and_return(store_2)
      spree_get :show, id: product.to_param
      expect(response.response_code).to be(404)
    end
  end

  describe '#show to a product w/ store' do
    let!(:store) { create(:store) }

    before do
      product.stores << store
    end

    it 'returns http success' do
      allow(subject).to receive(:current_store).and_return(store)
      spree_get :show, id: product.to_param
      expect(response.response_code).to be(200)
    end
  end
end
