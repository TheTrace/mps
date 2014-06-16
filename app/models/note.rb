class Note < ActiveRecord::Base
	belongs_to :job
	belongs_to :user

	class NoteType
		GENERAL = "general"
		PHONE = "phone"
		EMAIL = "email"
		TANDC = "terms_conditions"
		MEETING = "meeting"
		TRAVEL = "travel"
		TRANSPORT = "transport"
		PARKING = "parking"
		GROUNDVISIT = "groundvisit"
		SURVEY = "survey"
		MEDIATION = "mediation"
		ADMINFEE = "adminfee"
		INVOICESENT = "invoice_sent"
		INVOICEPAID = "invoice_paid"
		DECISION = "decision"
		ARRANGEMENT = "arrangement"
		REQFORCHANGE = "req_change"

		NAMES = {
			GENERAL => "General",
			PHONE => "Phone call",
			EMAIL => "Email",
			TANDC => "Terms and conditions",
			MEETING => "Meeting",
			TRAVEL => "Travel (time)",
			TRANSPORT => "Transport (cost)",
			PARKING => "Parking",
			GROUNDVISIT => "Ground visit",
			SURVEY => "Survey",
			MEDIATION => "Mediation fee",
			ADMINFEE => "Admin fee",
			INVOICESENT => "Invoice sent",
			INVOICEPAID => "Invoice paid",
			DECISION => "Decision",
			ARRANGEMENT => "Arrangement change/new",
			REQFORCHANGE => "Request for change",
		}

		ALL = [GENERAL, PHONE, EMAIL, TANDC, MEETING, TRAVEL, TRANSPORT, PARKING, GROUNDVISIT, SURVEY, MEDIATION, ADMINFEE, INVOICESENT, INVOICEPAID, DECISION, ARRANGEMENT, REQFORCHANGE]

		def self.for_select
			ALL.map{|t|[NAMES[t], t]}
		end
	end

	def time_date_formatted show_day = false, show_year = true
		# Feb 2012 - The has_start_time now means that the times are used. The date_end will be there always, just need to check if it's the same date as date_start
		return '?' unless self.the_date

		#times = "("
		times = ""
		dte_str = "%d %b"
		dte_str = "%a, " + dte_str if show_day
		dte_str += " %y" if self.the_date.year != DateTime.now.year && show_year
		times += self.the_date.strftime(dte_str)
		times += self.the_date.strftime(" %H:%M ")
		#times += ")"

		times
	end
  
  	def log user_id, type = Log::Types::CREATE_NOTE
		j_id = self.job.id if self.job
		Log.create(detail: self.title, type_str: type, note_id: self.id, job_id: j_id, user_id: user_id )
 	end

end
