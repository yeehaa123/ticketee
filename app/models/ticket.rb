class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  attr_accessible :description, :user, :title, :assets_attributes

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_many :assets
  accepts_nested_attributes_for :assets
end