Spree::StoreController.class_eval do
  before_filter :set_body_id

  def set_body_id
    @body_id = current_store.code
  end
end