class Note < ActiveRecord::Base
	belongs_to :job

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
end
