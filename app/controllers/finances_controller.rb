class FinancesController < ApplicationController
	def index
		@jobs = Job.all
	end
end
