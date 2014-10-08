class Trip < ActiveRecord::Base
  belongs_to :owner, class_name: User
  #has_many :costs, -> { order :priority }, foreign_key: :list_id, dependent: :destroy
  def costs
    ['flight']
  end
  
  validates :owner, presence: true
  validates :title, presence: true
end
