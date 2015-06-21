class FillEmptyNamesInTaskLists < ActiveRecord::Migration
  def change
    TaskList.where("name IS NULL").update_all "name = 'My First List'"
  end
end
