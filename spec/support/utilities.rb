include ApplicationHelper

def new_user
  User.new(name: 'Example User', email: 'user@example.com')
end

def duplicate_user(user)
  duplicate = user.dup
  duplicate.email = user.email.upcase
  duplicate.save
end

def invalid_adresses
  %w{ user@foo,com user_at_foo.org example.user@foo.
                    foo@bar_baz.com foo@bar+baz.com }
end

def valid_adresses
  %w{ user@foo.COM A_US-EN@f.b.net frst.lst@foo.ru a+b@baz.fn }
end
