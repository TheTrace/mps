class Note < ActiveRecord::Base
	belongs_to :job

	class NoteType
		GENERAL = "general"
		PHONE = "phone"
		EMAIL = "email"
		MEETING = "meeting"
		TRAVEL = "travel"
		PARKING = "parking"
		TRANSPORT = "transport"
		SURVEY = "survey"
		DECISION = "decision"
		ARRANGEMENT = "arrangement"

		NAMES = {
			GENERAL => "General",
			PHONE => "Phone call",
			EMAIL => "Email",
			MEETING => "Meeting",
			TRAVEL => "Travel",
			PARKING => "Parking",
			TRANSPORT => "Transport",
			SURVEY => "Survey",
			DECISION => "Decision change",
			ARRANGEMENT => "Arrangement change/new"
		}

		ALL = [GENERAL, PHONE, EMAIL, MEETING, TRAVEL, PARKING, TRANSPORT, SURVEY, DECISION, ARRANGEMENT]

		def self.for_select
			ALL.map{|t|[NAMES[t], t]}
		end
	end
end
