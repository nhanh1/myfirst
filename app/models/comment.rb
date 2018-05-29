class Comment < ApplicationRecord
  belongs_to :user
  validates :body, presence: true,
                    length: { minimum: 5 }
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_ancestry
end
