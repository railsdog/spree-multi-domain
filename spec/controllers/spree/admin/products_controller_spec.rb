describe Spree::Admin::ProductsController, type: :controller do
  stub_authorization!

  describe '#index' do
    it 'renders index' do
      spree_get :index
      expect(response).to be_success
    end
  end

  describe '#update' do
    before do
      @product = create(:product)
      @store = create(:store)
    end

    context 'when no stores are selected' do
      it 'clears stores if they previously existed' do
        @product.stores << @store
        spree_put :update, id: @product.to_param, product: { name: @product.name }
        expect(@product.reload.store_ids).to be_empty
      end
    end

    context 'when a store is selected' do
      it 'clears stores' do
        spree_put :update, id: @product.to_param, product: { name: @product.name, store_ids: [@store.id] }
        expect(@product.reload.store_ids).to match_array [@store.id]
      end
    end
  end
end
