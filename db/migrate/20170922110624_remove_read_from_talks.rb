class RemoveReadFromTalks < ActiveRecord::Migration[5.1]
  def change
    remove_column :talks, :read, :false
  end
end
