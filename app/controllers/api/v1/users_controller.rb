class Api::V1::UsersController < Api::V1::AppController
	def profile
		base_respond current_user
	end
end
