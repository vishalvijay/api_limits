# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')


(0...10).each do |i|
    User.create!(email: "user#{i}@example.com", password: '001100', password_confirmation: '001100')
end


[
    {
        name: "minurl",
        url: "https://github.com/vishalvijay/minurl",
        description: "Sample url shortening service like Bit.ly or TinyURL http://www.mnul.in"
    },
    {
        name: "mym-android",
        url: "https://github.com/vishalvijay/mym-android",
        description: "Match Your Market (Mym) Introduction The application is a game called “Match Your Market” (Mym). The game is divided into two parts where the user is given a Virtual Share Market to get a feel of functioning of trading and a Quiz part to enrich his know how about the various technicalities related to trading. He is provided with an environment"
    },
    {
        name: "VTU-Result-Parser-php-library",
        url: "https://github.com/vishalvijay/VTU-Result-Parser-php-library",
        description: "Php library for parsing VTU Results.This library can dyanamically parse the VTU site with respect to back pepers etc."
    },
    {
        name: "vtu-life-android",
        url: "https://github.com/vishalvijay/vtu-life-android",
        description: "VTU Life is the one stop solution to all the needs of the students of Visvesvaraya Technological University (VTU). VTU Life spawned from the need to access instant VTU Alerts, Previous Years Question Papers, Placement Papers, Placement Tips, Projects and all the resources that a student of VTU would need at their disposal at all times."
    }

].each do |repo|
    Repository.create!(repo)
end
