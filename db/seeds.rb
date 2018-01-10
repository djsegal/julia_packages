# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cur_call = "psql -f ./db/backup.db -d "

cur_call += Rails.configuration.database_configuration[Rails.env]["database"]

system(cur_call)

Batch.active_marker = Batch.last.marker
set_batch_marker :active, Batch.active_marker
