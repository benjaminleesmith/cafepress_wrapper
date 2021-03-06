# Copyright 2010-2011 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>
#
# This file is part of CafePress Wrapper.
# CafePress Wrapper is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CafePress Wrapper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CafePress Wrapper.  If not, see <http://www.gnu.org/licenses/>.

class UserToken < ActiveRecord::Base
  def self.set_token(user_token)
    if (ut = UserToken.first)
      ut.update_attributes(:token => user_token)
    else
      ut = UserToken.create(:token => user_token)
    end
    ut
  end

  def self.get_user_token
    ut = UserToken.first
    if ut && 30.minutes.ago < ut.updated_at
      user_token = ut.token
    else
      user_token = UserToken.set_token(CafePress.user_token).token
    end
    user_token
  end
end
