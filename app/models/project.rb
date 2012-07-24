class Project < ActiveRecord::Base
  attr_accessible :name
	
	has_many :tickets, dependent: :destroy

  validates :name, presence: true
end
