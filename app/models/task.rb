class Task < ApplicationRecord
    
    belongs_to :user
    
    validates :user_id, presence: true #参考https://teratail.com/questions/112886
    validates :content, presence: true, length: { maximum: 255 }
    validates :status, presence: true, length: { maximum: 10 }
end
