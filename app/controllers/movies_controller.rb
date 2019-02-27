class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # By calling @movies by the sort order (sort_by only performs ascending sort),
    # we are able to add a sort functionality
    @movies = Movie.order(params[:sort_by])
    
    # From part 2, if we have data in the ratings (added s) object, we will filter
    # the movies by that parameter and then sort them.
    if params[:ratings]
      @movies = Movie.where(:rating=> params[:ratings].keys).order(params[:sort_by])
    end
    
    # To be able to access the ratings, we set the object from the added code (Part 2)
    # to the all_ratings function in the movies controller. More on that in that code.
    @all_ratings = Movie.all_ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
