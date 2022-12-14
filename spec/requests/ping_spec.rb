require 'rails_helper'

RSpec.describe 'Pings', type: :request do

  describe 'ping spec test' do
    it 'pinging' do
      get pings_path, params: {}
      parsed_response_body = JSON.parse(response.body)
      expect(parsed_response_body).to eq({"result"=>"alive"})
    end
  end
end
