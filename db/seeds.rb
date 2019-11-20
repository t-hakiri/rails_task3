50.times do
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"

  User.create!( name: name, 
                email: email, 
                password: password, 
                password_confirmation: password
                )
end
