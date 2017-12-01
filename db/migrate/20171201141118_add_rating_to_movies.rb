class AddRatingToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :rating, :float, default: 0.0
  end
end
