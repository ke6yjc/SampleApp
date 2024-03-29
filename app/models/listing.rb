class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" }, :default_url => "missing.png"
	else
		has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" }, :default_url => "missing.png",
						  :storage => :dropbox,
    					  :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    					  :path => ":styles/:id_:filename"
	end
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :name, :description, :price, presence: true
	validates :price, numericality: { greater_than: 0 }
	validates :image, :attachment_presence => true

	belongs_to :user
end
