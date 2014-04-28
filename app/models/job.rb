class Job < ActiveRecord::Base
	has_many :tasks, :dependent => :destroy
	has_many :notes, :dependent => :destroy
	belongs_to :party_a, :class_name=> "Contact", :foreign_key => :party_a_id
	belongs_to :party_b, :class_name=> "Contact", :foreign_key => :party_b_id
	belongs_to :legal_representative, :class_name=> "Contact", :foreign_key => :legal_rep
	belongs_to :mediator_contact, :class_name=> "Contact", :foreign_key => :mediator

	class JobColours
		PRIMARY = "#428bca"
		SUCCESS = "#5cb85c"
		INFO = "#5bc0de"
		WARNNING = "#f0ad4e"
		DANGER = "#d9534f"

		ALL = [PRIMARY, SUCCESS, INFO, WARNNING, DANGER]
	end

	def self.for_select
		Job.all.map{|j|[j.ref, j.id]}
	end

	def add_tasks
		template_tasks = TemplateTask.order("template_tasks.sort_order, template_tasks.created_at")

		template_tasks.each do |t|
			new_task = Task.new()
			new_task.title = t.title
			new_task.text = t.text
			new_task.job_id = self.id
			new_task.tentative_due_date = DateTime.now() + t.due_days.to_i
			new_task.due_date = t.hard_due_days.blank? ? nil : DateTime.now() + t.hard_due_days
			new_task.sort_order = t.sort_order
			new_task.is_financial = t.is_financial
			new_task.save()
		end
	end

	def party_a_name
		party_a.blank? ? "?" : party_a.last_name
	end

	def party_b_name
		party_b.blank? ? "?" : party_b.last_name
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
			next unless !t.task_complete?
			next unless t.is_financial
			sum += t.cost.to_f if !t.cost.blank?
		end
		notes.each do |n|
			sum += n.cost.to_f if !n.cost.blank?
		end
		return sum
	end

	def received
		sum = 0.00
		tasks.each do |t|
			next unless t.task_complete?
			next unless t.is_financial
			sum += t.cost.to_f if !t.cost.blank?
		end
		notes.each do |n|
			sum += n.cost.to_f if !n.cost.blank?
		end
		sum += fees_paid if !fees_paid.blank?
		return sum
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

end
