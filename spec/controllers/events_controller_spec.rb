require 'rails_helper'

RSpec.describe Public::EventsController, type: :controller do
  let!(:domain) { FactoryBot.create(:educational_domain) }
  let!(:event) { FactoryBot.create(:event, educational_domain: domain) }

  describe 'GET #index' do
    context 'with format: :html' do
      it 'returns http success' do
        get :index, format: :html

        expect(response).to have_http_status(:success)
      end
    end

    context 'with format: :ics' do
      it 'returns http success' do
        get :index, format: :ics

        expect(response).to have_http_status(:success)
      end
    end

    context 'with format: :vcs' do
      it 'returns http success' do
        get :index, format: :vcs

        expect(response).to have_http_status(:success)
      end
    end

    context 'with format: :json' do
      it 'returns http success' do
        get :index, format: :json

        expect(response).to have_http_status(:success)
      end

      it 'returns valid JSON' do
        get :index, format: :json

        expect(JSON.parse(response.body)).to be_a Array
        expect(JSON.parse(response.body)).to satisfy { |value| value.count == 1 }
      end
    end
  end
end
