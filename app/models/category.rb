class Category < ApplicationRecord
  has_many :screenshots
  serialize :keywords
end
