class Api::V1::RepositoriesController < Api::V1::AppController
	def index
		base_respond Repository.all
	end

    def show
        base_respond Repository.find params[:id]
    end

    def search
        base_respond Repository.search params[:query]
    end
end
