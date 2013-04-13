class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

    if @friendship.save
      mixpanel.track 'Contact added'
      redirect_to :back
      gflash :success => t(:'gflash.friendships.create.success', :user => User.find(@friendship.friend_id).username)
    else
      redirect_to :back
      gflash :error => true
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to :back
    gflash :success => t(:'gflash.friendships.destroy.success', :user => User.find(@friendship.friend_id).username)
  end
end
