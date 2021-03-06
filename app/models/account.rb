class Account < ActiveRecord::Base
  belongs_to :family_member, foreign_key: :family_member_login, foreign_type: :string
  belongs_to :currency
  has_many :currency_transactions
  has_many :debts
  scope :current_family_member, ->(user) {where family_member_login: user.family_member_login}
  scope :not_current_family_member, ->(user) {where.not family_member_login: user.family_member_login}
end
