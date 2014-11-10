module ApplicationHelper

  def generate_name(names)
    first_name = complete_or_split(names, "first").split(" ").map(&:capitalize).join
    last_name = complete_or_split(names, "last").split(" ").map(&:capitalize).join
    "#{first_name} #{last_name}"
  end

  def complete_or_split(names, key)
    name = random_from(names[key]["completes"])
    if name == "split"
      "#{random_from(names[key]["splits"]["front"])} - #{random_from(names[key]["splits"]["back"])}"
    else
      name
    end
  end

  def random_from(data_set)
    data_set[rand(data_set.count)]
  end
end
