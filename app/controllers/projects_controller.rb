class ProjectsController < ApplicationController
  before_filter :authenticate_client!

  def index
    @projects = Project.where("client_id = ?" , current_client)

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
    @project = Project.new(params[:project]) ; @project[:client_id] = current_client.id ;

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project , notice: 'Project was successfully created.' }
        format.json { render json: @project , status: :created , location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors , status: :unprocessable_entity }
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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project , notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors , status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

end
