class Category < ActiveRecord::Base
  self.inheritance_column = nil
  # has_one :user
  belongs_to :category, foreign_key: :parent_category_id
  has_many :categories, foreign_key: :parent_category_id
  has_many :currency_transactions

  def self.child_categories(id)
    self.where(id: id) + self.where(parent_category_id: id).each { |child_category|
      child_category.child_categories child_category.id
    }
  end

end
