require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe 'GET /' do
    before { get root_path }
    it 'succeeds' do
      expect(response).to be_success
    end
    it 'outputs links to the three principal sections of the site' do
      ['CRUD', 'Quiz', 'Random Question'].each do |string|
        expect(response.body).to include string
      end
    end
  end
end
