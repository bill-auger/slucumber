class ProjectsController < ApplicationController

  def index
    @projects = Project.where("client_id = ?" , current_client)

    respond_to do | format |
      format.html
    end
  end

  def new
    @project = Project.new

    respond_to do | format |
      format.html
    end
  end
end
