module SessionsHelper
  include ApplicationHelper
  def sign_in(user)
    remember_token = new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    redirect_to root_path unless current_user
    #user = current_user
    #if user != nil
    #  user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    #  cookies.delete(:remember_token)
    #  self.current_user = nil
    #end
  end

  def sign_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = encrypt(cookies[:remember_token])
    @current_user ||= Admin.find_by(remember_token: remember_token) || FamilyMember.find_by(remember_token: remember_token)
  end

  def current_family=(family)
    @current_family = family
  end

  def current_family
    @current_family = Family.find_by id: current_user.family_id
  end
end
