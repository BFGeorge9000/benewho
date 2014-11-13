class PagesController < ApplicationController
  include Names

  def show
    @permutations = Names.total_permutations
    @amazon = Names.random_from(Names.amazon_links["text_and_images"])
    @name = Name.find_by_name!(Names.generate_name(Names.normalized_name_data))
  end
end
