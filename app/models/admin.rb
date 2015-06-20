class Admin < ActiveRecord::Base
  include ApplicationHelper
  has_many :currencies
  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  before_save {self.email.downcase!}
  before_create :create_remember_token
  has_secure_password

  private
  def create_remember_token
    self.remember_token = encrypt(new_remember_token)
  end

end
