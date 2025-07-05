namespace :event_ideas do
  desc "Delete all EventIdeas and reseed them"
  task reseed: :environment do
    puts "Deleting all EventIdeas..."
    EventIdea.delete_all

    puts "Reloading event ideas from db/seeds/event_ideas.rb..."
    load Rails.root.join("db", "seeds", "event_ideas.rb")

    puts "Done reseeding EventIdeas."
  end
end
