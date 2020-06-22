class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, :text, presence: true
  validates :title, :length => {:minimum => 2}, :uniqueness => true
  validates :text, :length => {:minimum => 5, :maximum => 15}
end
