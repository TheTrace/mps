class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @jobs = Job.order("jobs.reference DESC").all
    #@tasks = Task.joins("left join jobs on jobs.id = tasks.id").order("jobs.reference,tasks.sort_order").all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id

    respond_to do |format|
      if @task.save
        # Log the creation of the task
        @task.log(@current_user.id, Log::Types::CREATE_TASK)
        if params[:from] == "job"
          redirect_to job_path(@task.job), notice: 'Task was successfully created.'
          return
        elsif params[:from] == "tasklist"
          redirect_to tasklist_jobs_path, notice: 'Task was successfully created.'
          return
        else
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
          format.json { render action: 'show', status: :created, location: @task }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      # Log the update of the task
      @task.log(@current_user.id, Log::Types::UPDATE_TASK)
      bdone = false
      if params[:from] && !params[:from].blank?
        if params[:from].eql?("job") && @task.job
          bdone = true
          redirect_to @task.job, notice: 'Task was successfully updated.'
          return
        elsif params[:from].eql?("tasklist")
          bdone = true
          redirect_to tasklist_jobs_path, notice: 'Task was successfully updated.'
          return
        end
      elsif !bdone
        redirect_to @task, notice: 'Task was successfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  def complete_a
    set_task
    if @task.a_complete?
      @task.update_attribute(:party_a_complete_date, nil)
      @task.log(@current_user.id, Log::Types::UNCOMPLETE_TASK_A)
    else
      @task.update_attribute(:party_a_complete_date, DateTime.now)
      @task.log(@current_user.id, Log::Types::COMPLETE_TASK_A)
    end
    render :text => ( @task.a_complete? ? ( @task.check_complete? ? 'allcomplete' : 'complete') : 'uncomplete' )
  end

  def complete_b
    set_task
    if @task.b_complete?
      @task.update_attribute(:party_b_complete_date, nil)
      @task.log(@current_user.id, Log::Types::UNCOMPLETE_TASK_B)
    else
      @task.update_attribute(:party_b_complete_date, DateTime.now)
      @task.log(@current_user.id, Log::Types::COMPLETE_TASK_B)
    end
    render :text => ( @task.b_complete? ? ( @task.check_complete? ? 'allcomplete' : 'complete') : 'uncomplete' )
  end

  # Call complete when "two" is false (ie only one checkbox & not 2, one for ptyA & one for ptyB)
  def complete
    set_task
    if @task.task_complete?
      @task.update_attributes(:party_a_complete_date => nil, :party_b_complete_date => nil, :complete_date => nil)
      @task.log(@current_user.id, Log::Types::UNCOMPLETE_TASK)
    else
      @task.update_attributes(:party_a_complete_date => DateTime.now, :party_b_complete_date => DateTime.now, :complete_date => DateTime.now)
      @task.log(@current_user.id, Log::Types::COMPLETE_TASK)
    end
    render :text => @task.task_complete? ? "allcomplete" : "uncomplete"
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.log(@current_user.id, Log::Types::DELETE_TASK)
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :text, :job_id, :party_a_complete_date, :party_b_complete_date, :complete_date, :tentative_due_date, :due_date, :sort_order, :cost, :is_financial, :two)
    end
end
