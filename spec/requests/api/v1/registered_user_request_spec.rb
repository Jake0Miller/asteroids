require 'rails_helper'

describe 'GET request' do
  describe 'As a registered user' do
    it 'I receive a JSON response' do
      user = create(:user, email: "uncle.jesse@example.com", name: "Jesse Katsopolis")
      ApiKey.create!(value: 'abc123', user: user)
      fav = user.favorites.create!(neo_reference_id: "2153306")

      get "/api/v1/user/favorites?api_key=abc123"

      JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200

      expect(response[:id] == fav.id)
      expect(response[:neo_reference_id] == "2153306")
      expect(response[:user_id] == user.id)

      expected = {'name': '153306 (2001 JL1)', 'is_potentially_hazardous_asteroid': false,}
      expect(response[:asteroid] == expected)
    end
  end
end
