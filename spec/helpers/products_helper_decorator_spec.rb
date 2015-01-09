describe Spree::ProductsHelper, type: :helper do
  before do
    @store     = create(:store)
    @taxonomy  = create(:taxonomy, store: @store)
    @taxonomy2 = create(:taxonomy)

    allow(helper).to receive(:current_store).and_return(@store)
  end

  describe '.get_taxonomies' do
    it 'only show taxonomies on current_store' do
      taxonomies = helper.get_taxonomies
      expect(taxonomies).to include(@taxonomy)
      expect(taxonomies).not_to include(@taxonomy2)
    end
  end
end
