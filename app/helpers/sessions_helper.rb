module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # returns User object or nil
  def current_user
    # Idiomatic ruby : Hitting the database only once
    @current_user ||= User.find_by(id: session[:user_id])

    # Above code has same output as below
    # if @current_user.nil?
    #   @current_user = User.find_by(id: session[:user_id])
    # else
    #   @current_user
    # end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
  end

  def current_user?(user)
    current_user == user
  end
end
