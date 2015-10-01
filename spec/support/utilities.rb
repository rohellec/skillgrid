include ApplicationHelper

def new_user
  User.new(name: 'Example User', email: 'user@example.com',
           password: 'foobar', password_confirmation: 'foobar')
end

def fill_in_signup(user)
  fill_in "Name",         with: user.name
  fill_in "Email",        with: user.email
  fill_in "Password",     with: user.password
  fill_in "Confirmation", with: user.password
end

def duplicate_user(user)
  duplicate = user.dup
  duplicate.email = user.email.upcase
  duplicate.save
end

def save_with_options(user, options = {})
  options.each { |key, value| user[key] = value }
  user.save
end

def invalid_adresses
  %w{ user@foo,com user_at_foo.org example.user@foo.
                    foo@bar_baz.com foo@bar+baz.com foo@bar..com }
end

def valid_adresses
  %w{ user@foo.COM A_US-EN@f.b.net frst.lst@foo.ru a+b@baz.fn }
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end
