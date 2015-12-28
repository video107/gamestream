class WithdrawRecordsController < ApplicationController

  def new
    @withdraw_record = current_user.withdraw_records.new
  end

  def create
    @withdraw_record = current_user.withdraw_records.new(withdraw_record_params)

    if @withdraw_record.save!
      redirect_to user_cases_path(current_user)
    else
      render :new
    end

  end

  private

  def withdraw_record_params
    params.require(:withdraw_record).permit(:amount, :user_id, :withdrawaler_nanme, :withdrawaler_phone,
                    :withdrawaler_bank_name, :withdrawaler_bank_branch_name, :withdrawaler_bank_name_code,
                    :withdrawaler_bank_account)
  end

end
