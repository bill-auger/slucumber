class RegistrationsController < Devise::RegistrationsController
  def update
    # allow the update form to submit without password
    if params[:client][:password].blank?
      params[:client].delete("password")
      params[:client].delete("password_confirmation")
    end

    # try update
    @client = Client.find(current_client.id)
    has_nick_changed = (params[:client][:nick] != @client.nick)
    params[:client][:previous_nick] = @client.nick if has_nick_changed
    render "edit" and return unless @client.update_attributes(params[:client])

    # sign in the client bypassing validation
    set_flash_message :notice , ((has_nick_changed)? :update_needs_confirmation : :updated)
    sign_in @client , :bypass => true
    redirect_to after_update_path_for(@client)
  end
end
