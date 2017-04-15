require 'rails_helper'
require 'spec_helper'

RSpec.describe SignupCancelController, type: :controller do
  describe 'GET /signup_cancel/index' do
    it 'works!' do
      get 'index'
      expect(response.status).to eq(302)
    end
  end
end
