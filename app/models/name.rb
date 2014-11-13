class Name < ActiveRecord::Base
  validates :first_name, :last_name, :views, :presence => true

  def self.find_by_name!(string)
    name_strings = string.split(" ")
    names = Name.where(first_name: name_strings.first, last_name: name_strings.last)
    case names.count
    when 0
      create_from_name!(string)
    when 1
      names.first.increase_views!
    else
      raise "Unexpected Name Matches"
    end
  end

  def self.create_from_name!(string)
    name_strings = string.split(" ")
    attrs = Hash.new.tap do |h|
      h[:first_name] = name_strings.first
      h[:last_name]  = name_strings.last
      h[:views]      = 1
    end
    create!(attrs)
  end

  def increase_views!
    update_attributes!({views: views+1})
  end

  def first_seen
    created_at
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end
