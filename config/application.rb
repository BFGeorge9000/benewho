require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bc
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    yaml = YAML.load_file("#{Rails.root}/config/name.yml")
    
    config.name_data = yaml

    # I don't like doing all this work in the raw, but delcaring methods here seems... troublesome.
    totals = Array.new
    yaml.keys.each do |key|
      splits = yaml[key]["splits"]["front"].count * yaml[key]["splits"]["back"].count
      totals << splits + yaml[key]["completes"].count
    end
    total_permutations = totals.first * totals.last

    config.name_permutations = total_permutations

    config.amazon_links = YAML.load_file("#{Rails.root}/config/amazon.yml")

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de   
  end
end
