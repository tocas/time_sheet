#encode UTF-8

Factory.define :user do |user|
  user.email                  { Factory.next(:email) }
  user.password               "password"
  user.password_confirmation  "password"
end

Factory.define :admin, :parent => :user do |f|
  f.admin true
end

Factory.define :work do |work|
  work.day          Date.today
  work.description  "New define work"
  work.time         4
  work.user_id      1
end


Factory.sequence(:email) do
  |n| "person#{n}@example.com" 
end