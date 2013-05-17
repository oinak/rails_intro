class EditionsController < ApplicationController
  before_filter :load_course 

  # GET /editions
  # GET /editions.json
  def index
    @editions = @course.editions.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @editions }
    end
  end

  # GET /editions/1
  # GET /editions/1.json
  def show
    @edition = @course.editions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @edition }
    end
  end

  # GET /editions/new
  # GET /editions/new.json
  def new
    @edition = @course.editions.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @edition }
    end
  end

  # GET /editions/1/edit
  def edit
    @edition = @course.editions.find(params[:id])
  end

  # POST /editions
  # POST /editions.json
  def create
    @edition = @course.editions.new(params[:edition])

    respond_to do |format|
      if @edition.save
        format.html { redirect_to [@course,@edition], notice: 'Edition was successfully created.' }
        format.json { render json: @edition, status: :created, location: @edition }
      else
        format.html { render action: "new" }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /editions/1
  # PUT /editions/1.json
  def update
    @edition = @course.editions.find(params[:id])

    respond_to do |format|
      if @edition.update_attributes(params[:edition])
        format.html { redirect_to [@course,@edition], notice: 'Edition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editions/1
  # DELETE /editions/1.json
  def destroy
    @edition = @course.editions.find(params[:id])
    @edition.destroy

    respond_to do |format|
      format.html { redirect_to course_editions_url(@course) }
      format.json { head :no_content }
    end
  end

  private

  def load_course
    @course = Course.find(params[:course_id])
  end
end
