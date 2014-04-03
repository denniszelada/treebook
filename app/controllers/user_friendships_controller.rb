class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
    if params[:user_id]
      @friend = User.find(params[:friend_id])
      @user_friendship = UserFriendship.new(friend: @friend)
    else
      flash[:error] = "Friend required"
    end
  end

end
