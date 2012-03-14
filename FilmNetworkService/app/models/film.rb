class Film < ActiveRecord::Base
  self.has_and_belongs_to_many :actors, :join_table => "film_actor"
  self.table_name = "film"
  self.primary_key = "film_id"
end
