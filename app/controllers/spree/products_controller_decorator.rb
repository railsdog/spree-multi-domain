Spree::ProductsController.class_eval do

  before_filter :can_show_product, :only => :show

  def index
    @searcher = build_searcher(params.merge(include_images: true))
    @products = @searcher.retrieve_products
    @taxonomies = get_taxonomies
  end

  private

  def can_show_product
    @product ||= Spree::Product.friendly.find(params[:id])
    if @product.stores.empty? || !@product.stores.include?(current_store)
      raise ActiveRecord::RecordNotFound
    end
  end

end
