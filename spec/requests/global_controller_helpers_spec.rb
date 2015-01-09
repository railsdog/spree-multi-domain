describe 'Global controller helpers', type: :request do
  let!(:store) { create :store }

  before do
    @tracker = create :tracker, store: store
    get '/'
  end

  it 'includes the right tracker' do
    expect(response.body).to include(@tracker.analytics_id)
  end

  it 'creates a store-aware order' do
    expect(controller.current_store).to eq store
  end

  it 'instantiates the correct store-bound tracker' do
    expect(controller.current_tracker).to eq @tracker
  end

  describe '.current_currency' do
    subject { controller.current_currency }

    context 'when store default_currency is nil' do
      it { is_expected.to eq 'USD' }
    end

    context 'when the current store default_currency empty' do
      let!(:store) { create :store, default_currency: '' }
      it { is_expected.to eq 'USD' }
    end

    context 'when the current store default_currency is a currency' do
      let!(:store) { create :store, default_currency: 'EUR' }
      it { is_expected.to eq 'EUR' }
    end

    context 'when session[:currency] set by spree_multi_currency' do
      before do
        session[:currency] = 'AUD'
      end

      let!(:aud) { ::Money::Currency.find('AUD') }
      let!(:eur) { ::Money::Currency.find('EUR') }
      let!(:usd) { ::Money::Currency.find('USD') }
      let!(:store) { create :store, default_currency: 'EUR' }

      it 'returns supported currencies' do
        allow(controller).to receive(:supported_currencies).and_return([aud, eur, usd])
        expect(controller.current_currency).to eq 'AUD'
      end

      it 'returns store currency if not supported' do
        allow(controller).to receive(:supported_currencies).and_return([eur, usd])
        expect(controller.current_currency).to eq 'EUR'
      end
    end
  end
end
