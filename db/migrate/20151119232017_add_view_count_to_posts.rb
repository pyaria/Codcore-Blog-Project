class AddViewCountToPosts < ActiveRecord::Migration
  def change
    add_column "posts", "views", :int, default: 0
  end
end
