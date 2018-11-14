# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  
  COLORS = [
    'black',
    'white',
    'orange'
  ]
  validates :birth_date, :color, :name, :sex, :description ,presence: true
  validates :color, :inclusion => {:in => Cat::COLORS}
  
  def age
    ((Time.zone.now - @birth_date.to_time) / 1.year.seconds).floor
  end
  
  
  has_many :rental_requests,
  foreign_key: :cat_id,
  class_name: :CatRentalRequest,
  dependent: :destroy
end
# Cat.create(birth_date: '2010-10-10', color: 'orange', name: 'Tom', sex: 'F', description: 'This is another cat')