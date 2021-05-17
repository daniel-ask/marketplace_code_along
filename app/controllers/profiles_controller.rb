class ProfilesController < ApplicationController
  def dashboard
    @profile = Profile.includes(user: { listings: [], purchases: [:listing]}).find(params[:id])
    @user = @profile.user
  end
end
