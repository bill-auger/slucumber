class ProjectsController < ApplicationController
  before_filter :authenticate_client!
  before_filter { @admin = current_client.is_admin }  
#  before_filter :admin_index , :only => :index
#  def admin_index ; redirect_to clients_path if current_client.is_admin ; end ;
#  def admin_destroy ; redirect_to edit_client_path @project.client_id if @admin ; end ;

  def index
    redirect_to clients_path and return if @admin

    @projects = Project.where("client_id = ?" , current_client)
    @longest_name = Project.display_projects(@projects)

    respond_to do | format |
      format.html
    end
  end

  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  def create
#    @project = Client.find(current_client.id).projects.build(params[:project])
    @project = current_client.projects.build(params[:project])

    respond_to do |format|
      if params[:commit] == "Cancel"
        format.html { redirect_to projects_path }
        format.json { head :no_content }
      elsif Project.find_by_name(params[:project][:name])
        format.html { render action: "new"  , :status => "Project already exists with that name" }
        format.json { render :json => @project.errors , :status => "Project already exists with that name" }
      elsif @project.save
        format.html { redirect_to edit_project_url(@project) , :notice => "Project was successfully created." }
        format.json { render :json => @project , :status => :created , :location => @project }
      else
        format.html { render action: "new" }
        format.json { render :json => @project.errors , :status => :unprocessable_entity }
      end
    end
  end

  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

def my_ajax
=begin
  @actor = nil ;
  (@actor.save && (render { :partial => "actor" , :object => @actor })) if params[:id] &&
      (@actor = Actor.find(params[:id])) &&
      ((params[:option] && (@actor.option = params[:option])) or
      (params[:name] && (@actor.name = params[:name])) or
      (params[:data] && (@actor.name = params[:data])))
=end
=begin
    @actor = Actor.find(params[:id])
    @actor.option = params[:option] if params[:option]
    @actor.name = params[:name] if params[:name]
    @actor.data = params[:data] if params[:data]
    @action.save ; render :partial => "actor" , :object => @actor
=end
end

  def edit
    @project = Project.find(params[:id])
print "\n\n\n\n\nprojects::edit n_events=" + ((@project.events.nil?)? "events=nil" : @project.events.size.to_s + "\n")

@initiators = {} ; @triggers = {} ; @receivers = {} ; @responses = {} ;
    @project.events.each do | event |
=begin
@initiators[event] = Actorevent.initiator_id
@triggers[event] = Trigger.find event.trigger_id
@receivers[event] = Receiver.find event.receiver_id
@responses[event] = Response.find event.response_id
=end
#@initiator = Actor.find(event.initiator_id)
#event.find(event.initiator_id)
@initiators[event] = event.initiator ; @triggers[event] = event.trigger ;
@receivers[event] = event.receiver ; @responses[event] = event.response ;
#p "projects::edit id=" + event.id.to_s + " initiator=" + @initiators[event].id.to_s + " trigger=" + @triggers[event].id.to_s + " receiver=" + @receivers[event].id.to_s + " response=" + @responses[event].id.to_s
#p "projects::edit initiator.id=" + Actor.find(event.initiator.id).to_s ; p "project::edit trigger.id=" + Actor.find(event.trigger_id).to_s ; p "project::edit receiver.id=" + Actor.find(event.receiver_id).to_s ; p "project::edit response.id=" + Actor.find(event.response_id).to_s
    end

    respond_to do |format|
      format.html # .html.rb
      format.json { render json: @project }
    end

=begin
    respond_to do | format |
      if params[:commit] == "Cancel"
        format.html { redirect_to projects_path }
        format.json { head :no_content }
<%= text_field_tag customer , :name %> # Create a partial _customer.
<%= text_field_tag customer , :address %> # Create a partial _customer.
<% form_for @customer do | f | %> # Then in say your new view
   <%= render :partial=>"customer", :object=>@customer %>
   <%= f.submit_tag "Create" %>
=end
=begin
<% form_for :customer, @customer, :url => { :controller => "customers", :action => "editCustomer", :remote=> true } do |f| %>
  <%= render :partial=>"customers/customer", :object=>@customer %>
  <%= f.submit 'Save' %>
<% end %> # And my form_for

<div> # And my partial
  <%= text_field_tag customer, :name %>
  <%= text_field_tag customer, :kurz %>
  <%= text_field_tag customer, :info %>
  <%= text_field_tag customer, :strasse %>
  <%= text_field_tag customer, :plz %>
  <%= text_field_tag customer, :ort %>
  <%= text_field_tag customer, :tel %>
  <%= text_field_tag customer, :fax %>
  <%= text_field_tag customer, :mail %>
  <%= text_field_tag customer, :www%>
</div>
=end

=begin
remote_function(  :url => { :action => 'editCustomer',
                            :controller => 'customers'},
                            :with => "'id=' +$('specificCustomers').value");%>
=end
  end
def dbg_events
  dbg = " n_projects=" + Project.count.size.to_s + " n_events=" + @project.events.size.to_s + " [ "
  @project.events.each { | ev | dbg += ev.id.to_s + " , " } ; dbg + " ]" ;
end ;

  def update
    @project = Project.find(params[:id])
print "\n\n\n\nProjects>>update params[:commit]=" + params[:commit].to_s + " project.id=" + params[:id].to_s + "\n"

    if params[:commit] == "Cancel"
      respond_to do | format |
        format.html { redirect_to projects_path }
        format.json { head :no_content }
      end
    elsif params[:commit] == "Save" || true # && @project.update_attributes(params[:project])
p "Projects>>update update_attributes  IN=" + dbg_events ; first = @project.events.first ;
      if @project.update_attributes(params[:project])
p "Projects>>update update_attributes OUT=" + dbg_events + " Project update ok"
        @partial = (render :partial => 'events_form' , :object => @project).first.to_s
print "\nProjects>>update @partial=\n" + @partial + "\n"
#print "\nProjects>>update @partial=\n" + @partial[0..30] + "\n"
#tag_btn_text = "1234567890" ; @partial.gsub!(">#{tag_btn_text}<" , ">CLOBBERED<") ;
        respond_to do | format |
          format.json { @partial }
          format.html { raise "wtf" }
        end
      else
p "Projects>>update update_attributes OUT=" + dbg_events + " Project update fail."
        respond_to do | format |
          format.html { render action: "edit" }
          format.json {}
        end
      end
    else
p "Projects>>update update_attributes OUT=" + dbg_events + " Project update invalid"
      format.html { redirect_to edit_project_path(@project) , { :notice => "Project was successfully updated." } }
      format.json { head :no_content }
    end
  end
=begin
  def update
    @project = Project.find(params[:id])
print "\n\n\n\nProjects>>update params[:commit]=" + params[:commit].to_s + " project.id=" + params[:id].to_s + "\n"

    respond_to do | format |
      if params[:commit] == "Cancel"
        format.html { redirect_to projects_path }
        format.json { head :no_content }
#      elsif params[:commit] == "Save" && @project.update_attributes(params[:project])
      elsif params[:commit] == "Save" || true
p "Projects>>update update_attributes  IN=" + dbg_events ; first = @project.events.first ;
#(p "Projects>>update update_attributes first initiator  IN=" + first.initiator.id.to_s + " trigger="  + first.trigger.id.to_s + " receiver="  + first.receiver.id.to_s + " response="  + first.response.id.to_s) unless first.nil? || first.id.nil?
        if @project.update_attributes(params[:project])
#p "Projects>>update update_attributes OUT=" + dbg_events
#(p "Projects>>update update_attributes first initiator OUT=" + first.initiator.id.to_s + " trigger="  + first.trigger.id.to_s + " receiver="  + first.receiver.id.to_s + " response="  + first.response.id.to_s) unless first.nil? || first.id.nil?
#@project.events.first.trigger.data = ":)" ; @project.save ;

# NOTE: rend = (render :html => { :partial => 'events_form' , :object => @project })
#rend = (render :action => :edit , :format => :html)
#p "rend.class=" + rend.class.to_s + " rend.first.class=" + rend.first.class.to_s ;
#=begin
id = @project.id.to_s
@partial = (render :html => { :partial => 'events_form' , :object => @project }).first.to_s
#@partial = (render :action => :edit , :format => :html).first.to_s
#@partial = (render :action => :update , :format => :html).to_s
#@partial = (render 'projects/events_form').first.to_s
print "\nProjects>>update update_attributes @partial=\n" + @partial + "\n"
@partial.gsub!(">1234567890<" , ">YAY<")
#=end
#          format.html { redirect_to edit_project_path(@project) , { :notice => 'Project was successfully updated.' } }
#          format.json { 'console.log("' + (render "events_form") + '") ;' }
          format.json {}
#format.html { render :partial => 'events_form' , :object => @project ; return ; }
#format.html { raise "wtf" }
#          format.json { render :json => 'document.getElementById("edit_project_' + @project.id.to_s + '").innerHTML = "' + @partial + '" ;'; }
#          format.json { render :json => 'console.log("' + (render @project) + '");' }
#          format.json { render :json => 'console.log("' + @partial + '");' }
#          format.html { render action: "edit" }
#          format.json { 'renderEventsForm(' + @project.id.to_s + ' , "' + (render :action => :edit) + '") ;' }
          #format.json { 'renderEventsForm(' + id + ' , "' + partial + '") ;' }

# format.json {
# p "Projects>>update json id=" + id
# '$("#" + "events_form_" + id).replaceWith("' + (render :json => { :partial => 'events_form' , :object => @project }).first + '") ;'
# '$("#" + "events_form_" + id).replaceWith("<div>hello</div>") ;' }

# 'renderEventsForm(' + id + ' , "' + partial + '") ;' }
        else
p "Projects>>update update_attributes OUT=" + dbg_events + " Project save fail."
          format.html { render action: "edit" }
#format.html { redirect_to edit_project_path(@project) , { :notice => "Project save fail." } }
#          format.json { render json: @project.errors , status: :unprocessable_entity }
format.json {}
        end
      else
        format.html { redirect_to edit_project_path(@project) , { :notice => "Project was successfully updated." } }
        format.json { head :no_content }
      end
    end
  end
=end
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html do
        url = (@admin)? (edit_client_path @project.client_id) : projects_url
        redirect_to url , notice: "Project was successfully deleted."
      end
      format.json { head :no_content }
    end
  end

end
