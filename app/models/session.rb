class Session
  include ActiveModel::Model # No need database, model itself only

  attr_accessor :email, :password # set getter and setter

  validates :email, presence: true
  validates :password, presence: true
end
