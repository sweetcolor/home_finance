class Debt < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :account_give_loan, foreign_key: :give_loan_id, class_name: Account
  belongs_to :account_borrow_debt, foreign_key: :borrow_debt_id, class_name: Account
  belongs_to :currency
  has_many :payout_debts

  enum type: {борг: 'борг', позика: 'позика'}

  scope :current_family_member_debts, ->(user) {where borrow_debt_id: Account.where(
                                                          family_member_login: user.family_member_login
                                                      )}
  scope :current_family_member_loans, ->(user) {where give_loan_id: Account.where(
                                                          family_member_login: user.family_member_login
                                                      )}

  def name
    family_member_login + ' ' + total_sum.to_s
  end
end
