require 'rails_helper'
require 'spec_helper'

feature 'Facebook Authentication' do
  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    Rails.application.env_config["omniauth.params"] = {'user_type' => 'host'}
  end

  scenario 'go to top page if the account is already registered' do
    create(:facebook_user)
    set_omniauth_facebook({})
    visit '/users/auth/facebook?user_type=host'
    expect(page).to have_content 'Successfully authenticated from Facebook account'
  end

  scenario 'go to registration page if the account is not registered' do
    set_omniauth_facebook({ uid: '10001', info: { email: 'taro@example.com'}, extra: { raw_info: { name: 'Taro Yamada'}} })
    visit '/'
    expect(page).to have_content("Sign in with Facebook")
    first('.navbar').click_link('Sign in with Facebook')

    # visit '/users/auth/facebook?user_type=host'
    expect(page).to have_selector("input[type=submit][value='Sign up']")

    fill_in "user_biography", with: "my bio"
    fill_in "user_name", with: "taro"
    expect { find('input[name="commit"]').click }.to change(User, :count).by(1)
    expect(page).to have_content 'Welcome! You have signed up successfully'

    visit '/users/edit'
    expect(page).to have_content 'Edit User'
    expect(page).not_to have_field 'user_current_password'
    fill_in "user_biography", with: "my bio2"
    expect(page).to have_selector("input[type=submit][value='Update']")
    find('input[name="commit"]').click
    expect(User.where(:uid => '10001').pluck('biography').first).to eq('my bio2')
  end
end

feature 'Twitter Authentication' do
  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    Rails.application.env_config["omniauth.params"] = {'user_type' => 'host'}
  end

  scenario 'go to top page if the account is already registered' do
    create(:twitter_user)
    set_omniauth_twitter({})
    visit '/users/auth/twitter?user_type=host'
    expect(page).to have_content 'Successfully authenticated from Twitter account'
  end

  scenario 'go to registration page if the account is not registered' do
    set_omniauth_twitter({ uid: '20001', info: { nickname: 'foobar'}})
    visit '/'
    expect(page).to have_content("Sign in with Twitter")
    first('.navbar').click_link('Sign in with Twitter')

    # visit '/users/auth/twitter?user_type=host'
    expect(page).to have_selector("input[type=submit][value='Sign up']")

    fill_in "user_biography", with: "my bio"
    fill_in "user_email", with: "foobar@example.com"
    expect { find('input[name="commit"]').click }.to change(User, :count).by(1)
    expect(page).to have_content 'Welcome! You have signed up successfully'

    visit '/users/edit'
    expect(page).to have_content 'Edit User'
    expect(page).not_to have_field 'user_current_password'
    fill_in "user_biography", with: "my bio2"
    expect(page).to have_selector("input[type=submit][value='Update']")
    find('input[name="commit"]').click
    expect(User.where(:uid => '20001').pluck('biography').first).to eq('my bio2')
  end
end
