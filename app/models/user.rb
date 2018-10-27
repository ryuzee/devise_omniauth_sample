class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :password_expirable, :password_archivable
  validates :name, presence: true, uniqueness: true
  validates :display_name, presence: true, length: { maximum: 50 }
  validates :biography, presence: true, length: { maximum: 1024 }

  def password_required?
    # super && provider.blank?
    provider.blank?
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.find_for_facebook_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.create(name:     auth.extra.raw_info.username,
                         display_name: auth.extra.raw_info.name,
                         biography: '',
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    auth.info.email,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20])
    end
    user
  end

  def self.find_for_twitter_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(name:     auth.info.nickname,
                         display_name: auth.info.name,
                         biography: auth.info.description,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    '',
                         password: Devise.friendly_token[0, 20])
    end
    user
  end

  def update_with_password(params, *options)
    if not password_required?
      update_attributes(params, *options)
    else
      super
    end
  end
end
