# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  STATUS = ['PENDING',"APPROVED","DENIED"]
  validates :status, :inclusion => {:in=>CatRentalRequest::STATUS}
  
  belongs_to :cat,
  foreign_key: :cat_id,
  class_name: :Cat
  
  def overlapping_requests
  
    CatRentalRequest.where.not("start_date > #{self.end_date} AND  end_date < #{self.start_date} ")
  end
  
  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end
  
  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
    
  end
  
  def does_not_overlap_approved_request
    CatRentalRequest.exists?(overlapping_approved_requests)
  end
  
  
  def approve
    
     overlapping_pending_requests.each do |req|
      req.status = 'DENIED'
      # update(req.id)
      req.save
    end
    self.status = 'Approved'
    self.save
    
  end
  
  def deny
    self.status = 'DENIED'
  end
end
