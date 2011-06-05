Factory.define :user do |user|
  user.name                   "Test User"
  user.email                  "user@example.com"
  user.password               "password"
  user.password_confirmation  "password"
end

Factory.define :work do |work|
  work.day          Date.today
  work.description  "New define work"
  work.time         4
  work.user_id      1
end