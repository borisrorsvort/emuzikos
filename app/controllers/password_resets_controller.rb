class PasswordResetsController < ApplicationController
  # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
    before_filter :require_no_user
    before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

    def new
    end

    def create
      @user = User.find_by_email(params[:email])
      if @user
        @user.deliver_password_reset_instructions!
        gflash :success => true
        redirect_to root_path
      else
        gflash :error => t(:'gflash.password_resets.create.error', :email =>  params[:email]) 
        render :action => :new
      end
    end

    def edit
    end

    def update
      @user.password = params[:password]
      @user.password_confirmation = params[:password] # Only if your are using password confirmation
      if @user.save
        gflash :success => true
        redirect_to @user
      else
        render :action => :edit
      end
    end


    private

    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        gflash :error => true
        redirect_to root_url
      end
    end
end
