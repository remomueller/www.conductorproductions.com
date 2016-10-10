# frozen_string_literal: true

# Allows categories to be created and modified.
class CategoriesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_without_project

  before_action :set_category, only: [:show, :edit, :update, :destroy]


  # GET /categories
  # GET /categories.json
  def index
    @categories = @project.categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = @project.categories.new(position: @project.categories.count+1)
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = current_user.categories.where(project_id: @project.id).new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to [@project, @category], notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to [@project, @category], notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to project_categories_path(@project), notice: 'Category was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = @project.categories.find_by_param(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:top_level, :name, :slug, :position)
    end
end
