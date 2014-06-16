class TemplateTasksController < ApplicationController
  before_action :set_template_task, only: [:show, :edit, :update, :destroy]

  # GET /template_tasks
  # GET /template_tasks.json
  def index
    @template_tasks = TemplateTask.order(:sort_order).all
  end

  # GET /template_tasks/1
  # GET /template_tasks/1.json
  def show
  end

  # GET /template_tasks/new
  def new
    @template_task = TemplateTask.new
  end

  # GET /template_tasks/1/edit
  def edit
  end

  # POST /template_tasks
  # POST /template_tasks.json
  def create
    @template_task = TemplateTask.new(template_task_params)

    respond_to do |format|
      if @template_task.save
        @template_task.update_attribute(:user_id, @current_user.id)
        format.html { redirect_to @template_task, notice: 'Template task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @template_task }
      else
        format.html { render action: 'new' }
        format.json { render json: @template_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /template_tasks/1
  # PATCH/PUT /template_tasks/1.json
  def update
    respond_to do |format|
      if @template_task.update(template_task_params)
        format.html { redirect_to @template_task, notice: 'Template task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @template_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_tasks/1
  # DELETE /template_tasks/1.json
  def destroy
    @template_task.destroy
    respond_to do |format|
      format.html { redirect_to template_tasks_url }
      format.json { head :no_content }
    end
  end

  def sort_templates
    # Saves the new order of templates
    params[:sort_order].each do |key, value|
      #puts "tomplate = "+key.to_s
      #puts "sort_order = "+value.to_s
      t = TemplateTask.find(key)
      t.update_attribute(:sort_order, value) if t
    end

    redirect_to template_tasks_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template_task
      @template_task = TemplateTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_task_params
      params.require(:template_task).permit(:title, :text, :due_days, :hard_due_days, :sort_order, :is_financial, :two)
    end
end
