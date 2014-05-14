class Contact < ActiveRecord::Base
#	belongs_to :job_party_a, :class_name => "Contact", :foreign_key => :party_a_id
#	belongs_to :job_party_b, :class_name => "Contact", :foreign_key => :party_b_id
#	belongs_to :job_legal_rep, :class_name => "Contact", :foreign_key => :legal_rep
#	belongs_to :job_mediator, :class_name => "Contact", :foreign_key => :mediator

	def self.for_select
		Contact.order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def self.for_select_client
		Contact.where("contacts.client = true").order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def self.for_select_legal
		Contact.where("contacts.solicitor = true").order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def self.for_select_mediator
		Contact.where("contacts.mediator = true").order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def full_name
		[self.first_name,self.last_name].join(' ')
	end

	def types_str
		t = ""
		if self.client
			t = "Client"
			t += ", Mediator" if self.mediator
			t += ", Solicitor" if self.solicitor
		elsif self.mediator
			t = "Mediator"
			t += ", Solicitor" if self.solicitor
		elsif self.solicitor
			t = "Solicitor"
		end
		return t
	end

end
