class Project < ActiveRecord::Base
  attr_accessible :name
	
	has_many :tickets

  validates :name, presence: true
end
