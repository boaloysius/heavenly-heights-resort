require 'rails_helper'

RSpec.describe "Cabins API", type: :request do
  let!(:cabins) { create_list(:cabin, 10) }
  let(:cabin_id) { cabins.first.id }

  # Helper functions
  def json
    JSON.parse(response.body)
  end   
  
  def api_v1_path(endpoint)
    "/api/v1#{endpoint}"
  end    

  describe 'GET cabins api' do
    before { get api_v1_path('/cabins') }

    it 'returns cabins' do
      expect(json['data']).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET cabin by id api' do
    
    before { get api_v1_path("/cabins/#{cabin_id}") }

    context 'when the record exists' do
      it 'returns the cabin' do
        expect(json['data']).not_to be_empty
        expect(json['data']['id']).to eq(cabin_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:cabin_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['error']).to match(/Cabin not found/)
      end
    end
  end

  describe 'Create cabin api' do
    let(:valid_attributes) { 
      { 
        cabin: {
          maxCapacity: 4, 
          regularPrice: 200, 
          discount: 50, 
          name: '011', 
          # imageFile: fixture_file_upload('spec/fixtures/files/sample_cabin_image.webp', 'image/jpeg'),
          description: 'A lovely cabin' 
        }
      }
    }

    context 'when the request is valid' do
      before { post api_v1_path('/cabins'), params: valid_attributes }

      it 'creates a cabin' do
        expect(json['data']['name']).to eq('011')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_path('/cabins'), params: { cabin: {name: 'Foobar'} } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['errors'])
          .to include(
            'maxCapacity' => ["can't be blank"],
            'regularPrice' => ["can't be blank"],
            # 'imageFile' => ["can't be blank"],
            'description' => ["can't be blank"]
          )
      end
    end
  end

  describe 'Update cabin api' do
    let(:valid_attributes) { { cabin: {name: 'Updated Name'} } }

    context 'when the record exists' do
      before { put api_v1_path("/cabins/#{cabin_id}"), params: valid_attributes }

      it 'updates the record' do
        expect(json['data']['name']).to eq('Updated Name')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE cabin api' do
    before { delete api_v1_path("/cabins/#{cabin_id}") }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
