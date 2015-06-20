class CurrencyTransaction < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :category
  belongs_to :account
  belongs_to :currency

  enum type: {доходи: 'доходи', витрати: 'витрати'}
end
