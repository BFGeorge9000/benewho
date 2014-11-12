module Names
  mattr_accessor :amazon_links
  mattr_accessor :name_data
  mattr_accessor :normalized_name_data
  mattr_accessor :permutations

  class << self
    def normalize_splits(data_set)
      new_data_set = data_set.dup
      data_set.keys.map do |key|
        (data_set[key]["splits"]["front"].count + data_set[key]["splits"]["back"].count).times do
          new_data_set[key]["completes"] << "split"      
        end
      end
      new_data_set
    end

    def generate_name(names)
      first_name = complete_or_split(names, "first")
      last_name = complete_or_split(names, "last")
      "#{first_name} #{last_name}"
    end

    def complete_or_split(names, key)
      name = random_from(names[key]["completes"])
      if name == "split"
        name = "#{random_from(names[key]["splits"]["front"])} - #{random_from(names[key]["splits"]["back"])}"
      end
      name.split(" ").map(&:capitalize).join
    end

    def random_from(data_set)
      data_set[rand(data_set.count)]
    end

    def total_permutations
      totals = Array.new
      name_data.keys.each do |key|
        splits = name_data[key]["splits"]["front"].count * name_data[key]["splits"]["back"].count
        totals << splits + name_data[key]["completes"].count
      end
      totals.first * totals.last
    end
  end

  @@amazon_links         = YAML.load_file("#{Rails.root}/config/amazon.yml")
  @@name_data            = YAML.load_file("#{Rails.root}/config/name.yml")
  @@normalized_name_data = normalize_splits(name_data)
  @@permutations         = total_permutations

end