require 'rails_helper'

describe 'POST request' do
  describe 'As a registered user' do
    it 'I can favorite an asteroid' do
      user = create(:user, email: "uncle.jesse@example.com", name: "Jesse Katsopolis")
      ApiKey.create!(value: 'abc123', user: user)

      post "/api/v1/user/favorites?api_key=abc123&neo_reference_id=2021277"

      JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200

      expect(response[:id] == Favorite.last.id)
      expect(response[:neo_reference_id] == "2021277")
      expect(response[:user_id] == user.id)

      expected = {'name': '21277 (1996 TO5)', 'is_potentially_hazardous_asteroid': false}
      expect(response[:asteroid] == expected)
    end
  end
end
