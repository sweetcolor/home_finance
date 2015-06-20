class Debt < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :family_member, foreign_key: :family_member_login, foreign_type: :string
  belongs_to :account
  belongs_to :currency
  has_many :payout_debts

  enum type: {борг: 'борг', позика: 'позика'}

  scope :current_family_member_debts, ->(user) {where.not family_member_login: user.family_member_login}
  scope :current_family_member_loans, ->(user) {where family_member_login: user.family_member_login}

  def name
    family_member_login + ' ' + total_sum.to_s
  end
end
