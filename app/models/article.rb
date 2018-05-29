class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  validates :title, :body, :opening, :conclusion, :about_author, presence: true
end
