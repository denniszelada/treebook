class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name
  # attr_accessible :title, :body

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :profile_name, presence: true, uniqueness: true, format: {
    with: /^[a-zA-Z0-9_-]+$/,
    message: 'Must be formatted correctly.'
  }

  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships, conditions: {user_friendships: {state: 'accepted'} }

  has_many :pending_user_friendships, class_name: 'UserFriendship', foreign_key: :user_id, conditions: { state: 'pending'}
  has_many :pending_friends, through: :pending_user_friendships, source: :friend
  has_many :accepted_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'accepted' }
  has_many :accepted_friends, through: :accepted_user_friendships, source: :friend

  def full_name
    first_name + " " + last_name
  end

  def to_param
    profile_name
  end
end
