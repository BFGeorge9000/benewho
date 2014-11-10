class PagesController < ApplicationController
  def show
    yaml = normalize_splits(YAML.load_file("#{Rails.root}/config/name.yml"))
    @name = generate_name(yaml)
  end

  private

  def normalize_splits(data_set)
    new_data_set = data_set.dup
    data_set.keys.map do |key|
      (data_set[key]["splits"]["front"].count + data_set[key]["splits"]["back"].count).times do
        new_data_set[key]["completes"] << "split"      
      end
    end
    new_data_set
  end

end
