class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to pages_url, alert: 'Page not found.'
  end

  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new
    if params[:id]
      parent_id = params[:id].split('/').last
      @page.parent_id = parent_id if parent_id
    end
  end

  def create
    @page = Page.new page_params
    if @page.save
      redirect_to page_url(@page), notice: 'Page was successfully created.'
    else
      flash.now[:alert] = @page.errors.full_messages.join '; '
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update page_params
      redirect_to page_url(@page), notice: 'Page was successfully updated.'
    else
      flash.now[:alert] = @page.errors.full_messages.join '; '
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_url, notice: 'Page was successfully destroyed.'
  end

  private

  def set_page
    id_arrays = params[:id].split '/'
    id = id_arrays.pop

    if id_arrays.empty?
      ancestry = nil
    else
      ancestry = id_arrays.join '/'
    end

    @page = Page.find_by! id: id, ancestry: ancestry
  end

  def page_params
    params.require(:page).permit :id, :title, :body, :parent_id
  end
end
