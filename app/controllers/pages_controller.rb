class PagesController < ApplicationController
  def show
    yaml = YAML.load_file("#{Rails.root}/config/name.yml")
    @name = generate_name(yaml)
  end
end
