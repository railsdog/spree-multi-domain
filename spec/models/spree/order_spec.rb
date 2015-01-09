describe Spree::Order, type: :model do
  before do
    @store = create(:store)
    @order = create(:order, store: @store)
    @order2 = create(:order)
  end

  context '.by_store' do
    it 'correctly find products by store' do
      by_store = described_class.by_store(@store)
      expect(by_store).to include(@order)
      expect(by_store).not_to include(@order2)
    end
  end
end
