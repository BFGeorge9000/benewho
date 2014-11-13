class PrepopulateNameRecords < ActiveRecord::Migration
  def up
    1059.times do
      Name.find_by_name!(Names.generate_name(Names.normalized_name_data))
    end
  end

  def down
    raise IrreversibleMigrationError
  end
end
