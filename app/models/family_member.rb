class FamilyMember < ActiveRecord::Base
  has_one :family
  has_many :accounts
  has_many :debts
  include ApplicationHelper
  validates :name, :surname, :middle_name, presence: true
  before_create :create_remember_token
  has_secure_password

  def full_name
    surname + ' ' + name + ' ' + middle_name
  end

  private
  def create_remember_token
    self.remember_token = encrypt(new_remember_token)
  end

end