feature "Change Profile", %q{
  In order to increase customer satisfaction
  As a user
  I want to manage my profile
} do

  background do
    do_login_if_not_already
  end

  scenario "Should be able to add a youtube video with a valid id", :js => true do
    visit(edit_user_path(@user))
    fill_in 'user_youtube_video_id', :with => "vP1x2DbS55E"
    click_button 'Update'
    page.should have_content "Success"
  end

  scenario "Should not be able to add a youtube video with a invalid id", :js => true do
    visit(edit_user_path(@user))
    fill_in 'user_youtube_video_id', :with => "vP1xbS55E"
    click_button 'Update'
    page.should have_content "Error"
  end

end
