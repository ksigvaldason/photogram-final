# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos, foreign_key: :owner_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :fan_id
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: :sender_id
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: :recipient_id
  
  def followers
    User.where(id: received_follow_requests.where(status: "accepted").pluck(:sender_id))
  end

  def to_param  
    username
  end
  
  def following
    User.where(id: sent_follow_requests.where(status: "accepted").pluck(:recipient_id))
  end
end
