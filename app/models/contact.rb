class Contact < ActiveRecord::Base
#	belongs_to :job_party_a, :class_name => "Contact", :foreign_key => :party_a_id
#	belongs_to :job_party_b, :class_name => "Contact", :foreign_key => :party_b_id
#	belongs_to :job_legal_rep, :class_name => "Contact", :foreign_key => :legal_rep
#	belongs_to :job_mediator, :class_name => "Contact", :foreign_key => :mediator

	def self.for_select
		Contact.order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def self.for_select_client
		Contact.where("'contacts'.'client' = 't'").order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def self.for_select_legal
		Contact.where("'contacts'.'solicitor' = 't'").order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def self.for_select_mediator
		Contact.where("'contacts'.'mediator' = 't'").order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def full_name
		[self.first_name,self.last_name].join(' ')
	end

end
