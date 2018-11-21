# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Hello World!"
puts "這個種子檔會自動建立一個帳號, 並且創建 12 個 groups, 每個 group 各 30 個 posts"

create_account = User.create([email: 'example@gmail.com', password: '123123', password_confirmation: '123123', name: '测试用账号'])

create_groups = for i in 1..12 do
  Group.create!([title: "Group no.#{i}", description: "这是用种子建立的第 #{i} 个讨论版", user_id: "1"])
  GroupRelationship.create(group_id: i, user_id: 1)
  for k in 1..30 do
    Post.create!([group_id: "#{i}", content: "这是用种子建立的第 #{k} 个留言", user_id: "1"])
  end
end
