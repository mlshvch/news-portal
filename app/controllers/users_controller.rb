# frozen_string_literal: true

class UsersController < ApplicationController

  before_action :set_user

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Account was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_user
    @user = current_user
  end


  def user_params
    params.require(:user).permit(:email, :name, :surname, :username, :avatar)
  end

end
