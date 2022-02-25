class MoviesController < ApplicationController 
    before_action :require_signin, except: [:index, :show] 
    before_action :require_admin, except: [:index, :show]

    def index 
        @movies = Movie.released
    end

    def new 
        @movie = Movie.new
    end

    def create 
        @movie = Movie.new(movie_params)
        if @movie.save 
            redirect_to @movie, notice: 'Movie created successfully!' 
        else
            render :new 
        end
    end

    def show 
        @movie = Movie.find(params[:id])
        @fans = @movie.fans 
        @genres = @movie.genres.order(:name)
        if current_user 
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end

    def edit 
        @movie = Movie.find(params[:id])
    end

    def update 
        @movie = Movie.find(params[:id])
        if @movie.update(movie_params)
            redirect_to @movie, notice: 'Movie updated successfully!' 
        else
            render :edit 
        end
    end

    def destroy 
        @movie = Movie.find(params[:id])
        if @movie.destroy 
            redirect_to movies_url, alert: 'Movie deleted successfully.' 
        end
    end

    private 
        def movie_params
            params.require(:movie).permit(:title, :description, :total_gross, :rating, :released_on, 
                                          :director, :duration, :image_file_name, genre_ids: [] )
        end
end