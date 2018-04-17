# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
   {email: 'gordonramsey@gmail.com', password: 'pass123', name: 'Gordon Ramsey', location_lat: 51.512640,location_lon: -0.090390, bio: 'Swears a lot and has numerous TV shows in both UK and America'},
   {email: 'deliasmith@gmail.com', password: 'pass123', name: 'Delia Smith', location_lat: 51.512427,location_lon: -0.164376, bio: 'Known for teaching basic cookery skills in a no-nonsense style'},
   {email: 'ainsleyharriet@gmail.com', password: 'pass123', name: 'Ainsley Harriet', location_lat: 51.485949,location_lon: -0.106183, bio: 'Presenter for many BBC cooking shows'},
   {email: 'bella@dogchow.com', password: 'pass123', name: 'Bella Marusiak', location_lat: 51.533593, location_lon: -0.045855, bio: 'Not a fussy eater but will do many tricks for a tasty treat'},
   {email: 'vik@indianfood4u.com', password: 'pass123', name: 'Vikram Singh', location_lat: 51.536233, location_lon: -0.021151, bio: 'Not a TV personality- just really loves Indian food'},
   {email: 'jamie@oliver.com', password: 'pass123', name: 'Jamie Oliver', location_lat: 51.535739, location_lon: -0.077700, bio: 'Known for his British cuisine- just wants kids to eat healthy'},
   {email: 'zoe@wegotcoders.com', password: 'pass123', name: 'Zoe Flash', location_lat: 51.755733, location_lon: -0.010177, bio: 'Probably loves the flash more than she loves cooking but makes a mean brownie'},
   {email: 'nigella@nigellalawson.com', password: 'pass123', name: 'Nigella Lawson', location_lat: 17.172744, location_lon: -3.142876, bio: 'Food writer and journalist'}
]

User.create!(users)

