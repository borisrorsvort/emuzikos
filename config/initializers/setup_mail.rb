ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => 'donald.piret@gmail.com',
  :password             => '***',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
