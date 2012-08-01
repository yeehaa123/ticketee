class Ticket < ActiveRecord::Base
  searcher do
    label :tag, from: :tags, field: :name
  end
  
  belongs_to :project
  belongs_to :user
  belongs_to :state
  attr_accessible :description, :user, :title, :assets_attributes, :tags

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_many :assets
  accepts_nested_attributes_for :assets

  has_many :comments

  has_and_belongs_to_many :tags

	def tag!(tags)
		tags = tags.split(" ").map do |tag|
			Tag.find_or_create_by_name(tag)
		end
		
		self.tags << tags
	end
end