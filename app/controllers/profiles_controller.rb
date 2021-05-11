class ProfilesController < ApplicationController
  def dashboard
    @profile = Profile.find(params[:id])
    @user = @profile.user
    
  end
end
