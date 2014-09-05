class Job < ActiveRecord::Base
	has_many :tasks, :dependent => :destroy
	has_many :notes, :dependent => :destroy
	belongs_to :party_a, :class_name=> "Contact", :foreign_key => :party_a_id
	belongs_to :party_b, :class_name=> "Contact", :foreign_key => :party_b_id
	belongs_to :legal_rep_a, :class_name=> "Contact", :foreign_key => :legal_rep1
	belongs_to :legal_rep_b, :class_name=> "Contact", :foreign_key => :legal_rep2
	belongs_to :mediator_contact, :class_name=> "Contact", :foreign_key => :mediator
	belongs_to :mediator_1, :class_name=> "Contact", :foreign_key => :mediator1
	belongs_to :mediator_2, :class_name=> "Contact", :foreign_key => :mediator2
	belongs_to :mediator_3, :class_name=> "Contact", :foreign_key => :mediator3
	belongs_to :observer_1, :class_name=> "Contact", :foreign_key => :observer1
	belongs_to :observer_2, :class_name=> "Contact", :foreign_key => :observer2
	belongs_to :observer_3, :class_name=> "Contact", :foreign_key => :observer3

	class JobColours
		PRIMARY = "#428bca"
		SUCCESS = "#5cb85c"
		INFO = "#5bc0de"
		WARNNING = "#f0ad4e"
		DANGER = "#d9534f"

		ALL = [PRIMARY, SUCCESS, INFO, WARNNING, DANGER]
	end

	class JobStatus
		ENQUIRY = "enquiry"
		ACTIVE = "active"
		COMPLETE = "complete"
		ARCHIVE = "archive"

		ALL = [ENQUIRY, ACTIVE, COMPLETE, ARCHIVE]

		NAMES = {
			ENQUIRY => "Enquiry",
			ACTIVE => "Active",
			COMPLETE => "Complete",
			ARCHIVE => "Archive"
		}
		def self.status_select
			ALL.map{|s|[NAMES[s],s]}
		end
	end

	def name
		return ref
	end

	def self.for_select
		Job.all.map{|j|[j.ref, j.id]}
	end

	def add_tasks user_id
		# Note to self Jun-14 - just use tentative_due_date & forget about due_date (& hard_due_days)
		template_tasks = TemplateTask.order("template_tasks.sort_order, template_tasks.created_at")

		use_date = start_date.blank? ? DateTime.now() : start_date
		template_tasks.each do |t|
			new_task = Task.new()
			new_task.title = t.title
			new_task.text = t.text
			new_task.job_id = self.id
			new_task.tentative_due_date = use_date + t.due_days.to_i
			new_task.due_date = t.hard_due_days.blank? ? nil : use_date + t.hard_due_days
			new_task.sort_order = t.sort_order
			new_task.is_financial = t.is_financial
			new_task.template_task_id = t.id
			new_task.two = t.two
			new_task.user_id = user_id
			new_task.save()
		end
	end

	def update_tasks_date
		tasks.each do |tsk|
			use_date = start_date.blank? ? DateTime.now() : start_date
			tsk.update_attribute(:tentative_due_date, use_date + tsk.template_task.due_days.to_i) if !tsk.task_complete? && tsk.template_task
		end
	end

	def party_a_name
		party_a.blank? ? "?" : (party_a.last_name.blank? ? party_a.company : party_a.last_name)
	end

	def party_b_name
		party_b.blank? ? "?" : (party_b.last_name.blank? ? party_b.company : party_b.last_name)
	end

	def parties
		party_a_name + " v " + party_b_name
	end

	def ref
		reference.to_s + " " + parties
	end

	def owing
		sum = 0.00
		tasks.each do |t|
			#next unless !t.task_complete?
			next unless t.is_financial
			next if t.paid
			sum += t.cost.to_f if !t.cost.blank?
		end
		notes.each do |n|
			next if n.paid
			sum += n.cost.to_f if !n.cost.blank?
		end
		return sum
	end

	def received
		sum = 0.00
		tasks.each do |t|
			#next unless t.task_complete?
			next unless t.is_financial
			next unless t.paid
			sum += t.cost.to_f if !t.cost.blank?
		end
		notes.each do |n|
			next unless n.paid
			sum += n.cost.to_f if !n.cost.blank?
		end
		sum += fees_paid if !fees_paid.blank?
		return sum
	end

	def time_taken
		tot_m = 0.00
		tot_h = 0
		notes.each do |n|
			if !n.time_taken.blank?
				tot_h += (n.time_taken).to_i
				tot_m += (n.time_taken - (n.time_taken).to_i) * 60
			end
		end
		tot_h += (tot_m / 60).to_i
		tot = tot_h + ((tot_m/60) - (tot_m/60).to_i)
		return tot
	end

	def foreground_colour

		c = self.colour.to_s
		c = c[1..-1] if c =~ /^#/
		return nil if c.blank?

		r = c[0..1].to_i(16).to_f
		g = c[2..3].to_i(16).to_f
		b = c[4..5].to_i(16).to_f

		luminance = 1.0 - ( 0.299 * r + 0.587 * g + 0.114 * b) / 255.0
		luminance < 0.5 ? '#000000' : '#FFFFFF'

	end

  	def log user_id, type = Log::Types::CREATE_JOB, text = "Job create"
		Log.create(detail: text, type_str: type, job_id: self.id, user_id: user_id )
 	end

end
