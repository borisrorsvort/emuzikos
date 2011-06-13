class RegistrationsController < Devise::RegistrationsController
  
  # ONLY FOR RECAPTACH INTEGRATION WIHICH I DECIDED TO REMOVE.
  # def create
  #   if verify_recaptcha
  #     super
  #     gflash :success => true, :notice => true
  #   else
  #     build_resource
  #     clean_up_passwords(resource)
  #     flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
  #     render_with_scope :new
  #   end
  # end


end