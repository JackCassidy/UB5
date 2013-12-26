module LogInSupport

  def log_in_admin()
    visit new_admin_user_session_path
    save_and_open_page
    fill_in "Email", with: 'admin@example.com'
    fill_in "Password", with: 'password'
    click_button "Sign in"
  end

end