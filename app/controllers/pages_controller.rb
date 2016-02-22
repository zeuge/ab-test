class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new
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
    @page = Page.find params[:id]
  end

  def page_params
    params.require(:page).permit :name, :title, :body
  end

end
