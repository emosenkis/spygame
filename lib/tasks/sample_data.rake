namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
  task missions: :environment do
    File.open("lib/tasks/mission_templates.txt", 'rb').each_line { |x|
      i = x.split(" | ")
      MissionTemplate.create(title: i[0], description: i[1], image: i[2])
    }
  end

  task events: :environment do
    File.open("lib/tasks/event_templates.txt", 'rb').each_line { |x|
      i = x.split(" | ")
      EventTemplate.create(mission_template_id: i[0], parent_event_id: i[1], title: i[2], description: i[3])
    }
  end
end