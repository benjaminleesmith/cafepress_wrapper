class UserToken < ActiveRecord::Base
  def self.set_token(user_token)
    if (ut = UserToken.first)
      ut.update_attributes(:token => user_token)
    else
      UserToken.create(:token => user_token)
    end
  end
end
