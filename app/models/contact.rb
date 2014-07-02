class Contact < ActiveRecord::Base
	has_many :party_a, :class_name => "Job", :foreign_key => :party_a_id
	has_many :party_b, :class_name => "Job", :foreign_key => :party_b_id
	has_many :legal_rep1, :class_name => "Job", :foreign_key => :legal_rep1
	has_many :legal_rep2, :class_name => "Job", :foreign_key => :legal_rep2
	has_many :legal_rep3, :class_name => "Job", :foreign_key => :legal_rep3
	has_many :mediator0, :class_name => "Job", :foreign_key => :mediator
	has_many :mediator1, :class_name => "Job", :foreign_key => :mediator1
	has_many :mediator2, :class_name => "Job", :foreign_key => :mediator2
	has_many :mediator3, :class_name => "Job", :foreign_key => :mediator3
	has_many :observer1, :class_name => "Job", :foreign_key => :observer1
	has_many :observer2, :class_name => "Job", :foreign_key => :observer2
	has_many :observer3, :class_name => "Job", :foreign_key => :observer3

	def self.for_select
		Contact.order("contacts.last_name,contacts.first_name").map{|c|[[c.first_name,c.last_name].join(" "),c.id]}
	end 

	def self.for_select_client
		q = Contact.order("contacts.last_name,contacts.first_name")
		q = q.where("contacts.client = true") #if !Rails.env.development?
		q.map{|c|[ c.full_name, c.id ]}
	end 

	def self.for_select_legal
		q = Contact.order("contacts.last_name,contacts.first_name")
		q = q.where("contacts.solicitor = true") #if !Rails.env.development?
		q.map{|c|[ c.full_name, c.id ]}
	end 

	def self.for_select_mediator
		q = Contact.order("contacts.last_name,contacts.first_name")
		q = q.where("contacts.mediator = true") #if !Rails.env.development?
		q.map{|c|[ c.full_name, c.id ]}
	end 

	def full_name
		fn = [self.first_name,self.last_name].join(' ')
		fn = self.company if fn.blank?
		fn = "No Name" if fn.blank?
		fn
	end

	def name
		return full_name
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
