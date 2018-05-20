# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(32)       not null
#  display_name           :string(128)      not null
#  password               :string(255)      default(""), not null
#  admin                  :boolean          default(FALSE), not null
#  disabled               :boolean          default(FALSE)
#  created_at             :datetime         not null
#  modified_at            :datetime
#  biography              :text(65535)
#  slides_count           :integer          default(0)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  username               :string(255)      not null
#

FactoryBot.define do
  factory :facebook_user, class: User do
    uid 10000
    provider 'facebook'
    email 'test@example.com'
    display_name 'Yoshi'
    biography 'Bio'
    password 'password'
    name 'ryuzee'
    reset_password_token 'reset_password_token'
  end

  factory :twitter_user, class: User do
    uid 20000
    provider 'twitter'
    email 'john@example.com'
    display_name 'Jone'
    biography 'Jone is JOHN'
    password 'password'
    name 'john'
    reset_password_token 'reset_password_token'
  end
end
