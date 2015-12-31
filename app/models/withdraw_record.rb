class WithdrawRecord < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :withdrawaler_name, :withdrawaler_phone, :withdrawaler_bank_name, :withdrawaler_bank_branch_name, :withdrawaler_bank_name_code, :withdrawaler_bank_account, :amount
  validates_length_of :withdrawaler_phone, :is => 10
  validates_numericality_of :amount, :greater_than_or_equal_to => 1000
  validate :amount_limitation

  protected

  def amount_limitation
    errors.add(:amount, "overbudget") if self.amount > self.user.profit_money.to_i
  end
end
