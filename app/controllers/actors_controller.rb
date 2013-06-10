class ActorsController < ActionController::Base
#  protect_from_forgery
#http://localhost:3000/actors/_form.html
  def index ; @actors = Actor.all ; respond_to do | format |
p "Actors::index id=" + params[:id].to_s + " n_actors=" + @actors.size.class.to_s + " params[:actor]=" + params[:actor].to_s
    format.html render { { :partial => "actors" , :object => @actors } }
    format.js {}
  end ; end ;

#  def show ; @actor = Actor.find(params[:id]) ; render edit ; end ;
  def show ; @actor = Actor.find(params[:id]) ; respond_to do | format |
p "Actors::show id=" + params[:id].to_s + " @actor=" + @actors.class.to_s + " params[:actor]=" + params[:actor].to_s
    format.html render { { :partial => "actors/actor" , :object => @actor } }
    format.js {}
  end ; end ;
  
  def edit ; @actor = Actor.find(params[:id]) ; respond_to do | format |
p "Actors::edit id=" + params[:id].to_s + " @actor=" + @actors.class.to_s + " params[:actor]=" + params[:actor].to_s
      format.html render { { :partial => "actors/actor/edit" , :object => @actor } }
      format.js {}
  end ; end ;



                

  def update
p "Actor::update id=" + params[:id] + " actor=" + params[:actor]

    params[:id] && (@actor = Actor.find(params[:id])) &&
        (@actor.update_attributes params[:actor])
=begin
          ((params[:option] && (@actor.option = params[:option])) or
          (params[:name] && (@actor.name = params[:name])) or
          (params[:data] && (@actor.data = params[:data])))
=end

# req params was {"id"=>"_form","format"=>"html"}
    
    respond_to do | format | format.js {}
    end
  end
end
