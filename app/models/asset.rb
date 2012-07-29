class Asset < ActiveRecord::Base
  attr_accessible :asset
  
	belongs_to :ticket

  has_attached_file :asset, path: (Rails.root + "files/:id").to_s,
  													url: "/files/:id"
end
