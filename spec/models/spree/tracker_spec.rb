describe Spree::Tracker, type: :model do
  before do
    store = create(:store)
    @tracker = create(:tracker, store: store)
    another_store = create(:store, url: 'completely-different-store.com')
    @tracker2 = create(:tracker, store: another_store)
  end

  it 'pulls out the current tracker' do
    expect(Spree::Tracker.current('www.example.com')).to eq @tracker
  end
end
