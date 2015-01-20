class Destination < ActiveRecord::Base
  belongs_to :trip
  #has_many :costs, -> { order :priority }, foreign_key: :list_id, dependent: :destroy
  def costs
    ['flight']
  end
  
  validates :title, presence: true
end
