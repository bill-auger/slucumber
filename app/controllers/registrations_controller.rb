class RegistrationsController < Devise::RegistrationsController
  def update
    # required for settings form to submit when password is left blank
    if params[:client][:password].blank?
      params[:client].delete("password")
      params[:client].delete("password_confirmation")
    end

    @client = Client.find(current_client.id)
    render "edit" and return unless @client.update_attributes(params[:client])

    set_flash_message :notice , :updated
    # Sign in the client bypassing validation in case his password changed
    sign_in @client , :bypass => true
    redirect_to after_update_path_for(@client)
  end
end
