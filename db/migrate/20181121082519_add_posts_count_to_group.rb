class AddPostsCountToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :posts_count, :integer, default: 0

    Group.pluck(:id).each do |i|
      Group.reset_counters(i, :posts) 
    end
  end
end
