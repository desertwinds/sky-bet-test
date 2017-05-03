class User
  include ActiveModel::Model

  attr_accessor :firstname, :surname
  validates_presence_of [:firstname, :surname]

end