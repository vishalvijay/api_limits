class Api::V1::UsersController < Api::V1::AppController

	before_action :authenticate_user!, except: [:idex]

	def index
	end

	def profile
		respond_with current_user
	end
end