class Note < ActiveRecord::Base
	belongs_to :job

	class NoteType
		GENERAL = ""
		PHONE = "phone"
		DECISION = "decision"
		EMAIL = "email"
		ARRANGEMENT = "arrangement"

		NAMES = {
			GENERAL => "General",
			PHONE => "Phone call",
			DECISION => "Decision change",
			EMAIL => "Email",
			ARRANGEMENT => "Arrangement change/new"
		}

		ALL = [GENERAL, PHONE, DECISION, EMAIL, ARRANGEMENT]

		def self.for_select
			ALL.map{|t|[NAMES[t], t]}
		end
	end
end
