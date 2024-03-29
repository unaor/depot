# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  image_url   :string(255)
#  price       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders ,through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  attr_accessible :description, :image_url, :price, :title
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
   validates :image_url, allow_blank: true, format: {
                         with: %r{\.(gif|jpg|png)$}i,
                         message: 'must be a URL for GIF, JPG or PNG image.'}

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
    else
      erros.add(:base , 'Line items present')
      return false
    end
  end
end
