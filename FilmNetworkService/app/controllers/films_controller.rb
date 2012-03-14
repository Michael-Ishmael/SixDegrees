class FilmsController < ApplicationController
  # GET /films
  # GET /films.json
  def index
    @films = Film.select("film.film_id, title, description, count(film_actor.actor_id) as actor_count")
                .joins("inner join film_actor on film.film_id = film_actor.film_id")
                .group("film_id, title, description").order("count(film_actor.actor_id) desc").limit(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @films }
    end
  end

  # GET /films?actor_id=n
  def actor_films
    @actor = Actor.find(params["actor_id"])
    @films = @actor.films.select("film.film_id, title, description, fac.actor_count")
    .joins("inner join (select film_id, Count(actor_id) AS actor_count from film_actor group by film_id) fac on film.film_id = fac.film_id")
    .order("fac.actor_count desc")

    respond_to do |format|
      format.html
      format.json { render json: @films }
    end

  end

  # GET /films/1
  # GET /films/1.json
  def show
    @film = Film.select("film.film_id, title, description, count(film_actor.actor_id) as actor_count")
              .joins("inner join film_actor on film.film_id = film_actor.film_id")
              .group("film_id, title, description").find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @film }
    end
  end

  # GET /films/new
  # GET /films/new.json
  def new
    @film = Film.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @film }
    end
  end

  # GET /films/1/edit
  def edit
    @film = Film.find(params[:id])
  end

  # POST /films
  # POST /films.json
  def create
    @film = Film.new(params[:film])

    respond_to do |format|
      if @film.save
        format.html { redirect_to @film, notice: 'Film was successfully created.' }
        format.json { render json: @film, status: :created, location: @film }
      else
        format.html { render action: "new" }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /films/1
  # PUT /films/1.json
  def update
    @film = Film.find(params[:id])

    respond_to do |format|
      if @film.update_attributes(params[:film])
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1
  # DELETE /films/1.json
  def destroy
    @film = Film.find(params[:id])
    @film.destroy

    respond_to do |format|
      format.html { redirect_to films_url }
      format.json { head :no_content }
    end
  end
end
