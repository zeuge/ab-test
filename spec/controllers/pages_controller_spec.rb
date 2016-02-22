require 'rails_helper'

describe PagesController do
  let(:page) { create :page }
  let(:valid_attributes) { attributes_for :page, name: 'valid_name' }
  let(:invalid_attributes) { attributes_for :page, name: nil }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status :success
    end
    it 'assigns all pages as @pages' do
      page
      get :index
      expect(assigns(:pages)).to eq [page]
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: page.to_param
      expect(response).to have_http_status :success
    end
    it 'assigns the requested page as @page' do
      get :show, id: page.to_param
      expect(assigns(:page)).to eq page
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status :success
    end
    it 'assigns a new page as @page' do
      get :new
      expect(assigns(:page)).to be_a_new Page
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Page' do
        expect {
          post :create, page: valid_attributes
        }.to change(Page, :count).by 1
      end
      it 'assigns a newly created page as @page' do
        post :create, page: valid_attributes
        expect(assigns(:page)).to be_persisted
      end
      it 'redirects to the created page' do
        post :create, page: valid_attributes
        expect(response).to redirect_to page_url(Page.last)
      end
    end

    context 'with invalid params' do
      it 'does not save the new page' do
        expect {
          post :create, page: invalid_attributes
        }.to_not change(Page, :count)
      end
      it 're-renders the :new template' do
        post :create, page: invalid_attributes
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, id: page.to_param
      expect(response).to have_http_status :success
    end
    it 'assigns the requested page as @page' do
      get :edit, id: page.to_param
      expect(assigns(:page)).to eq page
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested page' do
        put :update, id: page.to_param, page: valid_attributes
        page.reload
        expect(page.name).to eq valid_attributes[:name]
      end
      it 'assigns the requested page as @page' do
        put :update, id: page.to_param, page: valid_attributes
        expect(assigns(:page)).to eq page
      end
      it 'redirects to the updated page' do
        put :update, id: page.to_param, page: valid_attributes
        expect(response).to redirect_to page_url(page)
      end
    end

    context 'with invalid params' do
      it "does not change page's attributes" do
        put :update, id: page.to_param, page: invalid_attributes
        page.reload
        expect(page.name).not_to eq invalid_attributes[:name]
      end
      it 're-renders the :edit template' do
        put :update, id: page.to_param, page: invalid_attributes
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested page' do
      page
      expect {
        delete :destroy, id: page.to_param
      }.to change(Page, :count).by -1
    end
    it 'redirects to the pages list' do
      delete :destroy, id: page.to_param
      expect(response).to redirect_to pages_url
    end
  end
end
