describe Spree::Admin::StoresController, type: :controller do
  stub_authorization!

  describe '#index' do
    it 'renders index' do
      spree_get :index
      expect(response).to be_success
    end
  end
end
