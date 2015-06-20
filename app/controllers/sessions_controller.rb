class SessionsController < ApplicationController
  def new

  end

  def create
    user_login = params[:session][:login]
    user = Admin.find_by_admin_login(user_login) || FamilyMember.find_by_family_member_login(user_login)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      if user.class.name == FamilyMember.new.class.name
        redirect_to family_member_path user['family_member_login']
      else
        redirect_to admin_path user['admin_login']
      end
    else
      render 'new'
    end
  end

  def destroy
    current_user.update_attribute(:remember_token, encrypt(new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
    redirect_to root_path
  end
end
