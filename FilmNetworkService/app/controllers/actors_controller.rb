class ActorsController < ApplicationController
  # GET /actors
  # GET /actors.json
  def index
    @actors = Actor.select("actor.actor_id, first_name, last_name, count(film_actor.film_id) as film_count")
    .joins("inner join film_actor on actor.actor_id = film_actor.actor_id")
    .group("actor_id, first_name, last_name").order("count(film_actor.film_id) desc").limit(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actors }
    end
  end

  def film_actors
    @film = Film.find(params["film_id"])
    @actors = @film.actors
      .select("actor.actor_id, first_name, last_name, fac.film_count")
      .joins("inner join (select actor_id, Count(film_id) AS film_count from film_actor group by actor_id) fac on actor.actor_id = fac.actor_id")
      .order("fac.film_count desc")

    respond_to do |format|
      format.html
      format.json { render json: @actors }
    end

  end

  # GET /actors/1
  # GET /actors/1.json
  def show
    @actor = Actor.select("actor.actor_id, first_name, last_name, count(film_actor.film_id) as film_count")
    .joins("inner join film_actor on actor.actor_id = film_actor.actor_id")
    .group("actor_id, first_name, last_name").find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actor }
    end
  end

  # GET /actors/new
  # GET /actors/new.json
  def new
    @actor = Actor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actor }
    end
  end

  # GET /actors/1/edit
  def edit
    @actor = Actor.find(params[:id])
  end

  # POST /actors
  # POST /actors.json
  def create
    @actor = Actor.new(params[:actor])

    respond_to do |format|
      if @actor.save
        format.html { redirect_to @actor, notice: 'Actor was successfully created.' }
        format.json { render json: @actor, status: :created, location: @actor }
      else
        format.html { render action: "new" }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /actors/1
  # PUT /actors/1.json
  def update
    @actor = Actor.find(params[:id])

    respond_to do |format|
      if @actor.update_attributes(params[:actor])
        format.html { redirect_to @actor, notice: 'Actor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actors/1
  # DELETE /actors/1.json
  def destroy
    @actor = Actor.find(params[:id])
    @actor.destroy

    respond_to do |format|
      format.html { redirect_to actors_url }
      format.json { head :no_content }
    end
  end
end
