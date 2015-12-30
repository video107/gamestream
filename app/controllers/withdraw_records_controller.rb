class WithdrawRecordsController < ApplicationController

  def new
    @withdraw_record = current_user.withdraw_records.new
    # current_user.update(total_earn_money: current_user.total_profit?)
  end

  def create
    @withdraw_record = current_user.withdraw_records.new(withdraw_record_params)

    # respond_to do |format|
      if @withdraw_record.save
        current_user.update(profit_money: current_user.total_earn_money.to_i - @withdraw_record.amount)
        # format.html {render :template => "withdraw_records/errors"}
        # format.js {
        #   render :template => "withdraw_records/success"
        # }
      redirect_to user_cases_path(current_user)
      flash[:alert] = "要求成功送出"
      else
        render :new
        # format.html {render :new}
      # end
    end

  end

  private

  def withdraw_record_params
    params.require(:withdraw_record).permit(:amount, :user_id, :withdrawaler_name, :withdrawaler_phone,
                    :withdrawaler_bank_name, :withdrawaler_bank_branch_name, :withdrawaler_bank_name_code,
                    :withdrawaler_bank_account)
  end

end
