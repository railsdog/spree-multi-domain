Spree::Tracker.class_eval do
  belongs_to :store

  def self.current(domain = nil)
    domain ||= Spree::Store.current.url
    Spree::Tracker.where(:active => true, :environment => Rails.env).joins(:store).where("spree_stores.url LIKE ?", "%#{domain}%").first
  end
end
