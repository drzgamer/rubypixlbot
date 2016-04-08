class Category < ActiveRecord::Base
  has_many :catrelations
  has_many :posts, through: :catrelation
end
