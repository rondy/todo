module AuthMacros

  def login!(user=nil)
    user ||= Factory(:user)
    @_current_user = user
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
  end

  def current_user
    @_current_user
  end

end