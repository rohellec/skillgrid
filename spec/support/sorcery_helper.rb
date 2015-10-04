module Sorcery
  module TestHelpers
    module Rails
      module Controller
        def login_user_and_remember(user = nil, test_context = {})
          user ||= @user
          @controller.send(:auto_login, user, should_remember = true)
          @controller.send(:after_login!, user, [user.send(user.sorcery_config.username_attribute_names.first), 'secret'])
        end
      end
    end
  end
end
