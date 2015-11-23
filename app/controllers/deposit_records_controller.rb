class DepositRecordsController < ApplicationController

  def new
    @deposit_record = current_user.deposit_records.new
  end

  def create
    @deposit_record = current_user.deposit_records.new(deposit_record_params)

    if @deposit_record.save!
      redirect_to user_cases_path(current_user)
    else
      render :new
    end

  end

  private

  def deposit_record_params
    params.require(:deposit_record).permit(:amount, :user_id, :withdrawaler_nanme, :withdrawaler_phone,
                    :withdrawaler_bank_name, :withdrawaler_bank_branch_name, :withdrawaler_bank_name_code,
                    :withdrawaler_bank_account)
  end

end
