class Actor < ActiveRecord::Base
  self.has_and_belongs_to_many :films, :join_table => "film_actor"
  self.table_name = "actor"
  self.primary_key = "actor_id"
end
