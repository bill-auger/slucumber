class ClientsController < ApplicationController
  before_filter :authenticate_client!
  before_filter { redirect_to root_path unless current_client.is_admin }

  def index
    @clients , @display_nicks , @longest_named_client = Client.display_clients(current_client)

    respond_to { | format | ; format.html }
  end

  def edit ; @client = Client.find(params[:id]) ; respond_to { | format | ; format.html } ; end ;

  def update
    @client = Client.find(params[:id])

    respond_to do | format |
      format.html do
        if params[:commit] == "Back"
          redirect_to clients_url
        elsif params[:commit] == "Destroy " + @client.nick ; @client.destroy ;
          redirect_to clients_url , :notice => "Client was successfully destroyed."
        elsif @client.update_attributes(params[:client])
          redirect_to edit_client_url(@client) , :notice => "Client was successfully updated."
        else
          render action: "edit"
        end
      end
    end
  end
end
