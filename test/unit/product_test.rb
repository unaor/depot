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

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "Product should not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test "product price must be positive" do
      product = Product.new(title:
      "My Book Title",
      description: "yyy",
      image_url:
      "zzz.jpg")
      product.price = -1
      assert product.invalid?
      product.price=1
      assert product.valid?
  end
  
    def new_product(image_url)
       Product.new(title:
      "My Book Title",
       description: "yyy",
       price:1,
       image_url:image_url)
  end
  test "image url" do
  assert new_product('fdf.fdf').invalid?
  assert new_product('fdf.jpg').valid?
  end
  
  test "uniqueness of title" do
    product1 = new_product('picture.jpg')
    product2 = new_product('lame.png')
    assert product1.valid? ,"should be valid"
    product1.save
    assert !product2.save ,"product 2 should not be valid"
  end
end
