# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# compile downloaded aozora csvs
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'csvs')
Rails.application.config.assets.precompile += %w( list_person_all_utf8.csv list_person_all_extended_utf8.csv )
