class User < ActiveRecord::Base
  devise :token_authenticatable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :task_lists, foreign_key: :owner_id
  has_many :trips, foreign_key: :owner_id

  before_save :ensure_authentication_token
  after_create :create_task_list

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end

  def create_task_list
    task_lists.create!(name: "My first list")
  end

  def first_list
    task_lists.first
  end

  def skip_confirmation!
    # self.confirmed_at = Time.now
  end
  
end
