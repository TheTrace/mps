class FinancesController < ApplicationController
	before_action :set_job, only: [:show, :edit, :update, :destroy]

	def index
		@jobs = Job.all
	end

	def show
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_job
			@job = Job.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def finance_params
			params.require(:job).permit(:title, :text, :reference, :party_a_id, :party_b_id, :legal_rep, :mediator, :fees_paid, :mediation_date)
		end
end
