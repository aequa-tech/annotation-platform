# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# fix loading ancestors https://github.com/rails/rails/issues/29112
require "thor"
shell = Thor::Base.shell.new

# loading common seeds
Dir[Rails.root.join("db/seeds/*.rb")].each do |seed|
  shell.say_status :sample, seed.to_s.gsub(Rails.root.to_s, "")
  load seed
end

# loading env specific seeds
unless Rails.env.production?
  Dir[Rails.root.join("db/seeds/dev_staging/*.rb")].sort_by(&:to_s).each do |seed|
    shell.say_status :sample, seed.to_s.gsub(Rails.root.to_s, "")

    load seed
  end

  # loading data_import
  Dir[Rails.root.join("db/seeds/data_import/*.rb")].sort_by(&:to_s).each do |seed|
    shell.say_status :sample, seed.to_s.gsub(Rails.root.to_s, "")

    load seed
  end
end
