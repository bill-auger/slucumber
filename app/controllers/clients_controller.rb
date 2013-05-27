class ClientsController < ApplicationController
  before_filter :authenticate_client!
  before_filter { redirect_to root_path unless current_client.is_admin }

  def index
    @clients = Client.all

    respond_to { | format | ; format.html }
  end

  def edit
    @client = Client.find(params[:id])

    respond_to { | format | ; format.html }
  end

  def update
    @client = Client.find(params[:id])

    respond_to do | format |
      if @client.update_attributes(params[:client])
        format.html { redirect_to edit_client_url(@client) , :notice => "Client was successfully updated." }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @client = Client.find(params[:id]) ; @client.destroy ;

    respond_to { |format| ; format.html { redirect_to clients_url , :notice => "Client was successfully destroyed." } }
  end

end
