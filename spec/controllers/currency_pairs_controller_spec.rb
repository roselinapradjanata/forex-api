require 'rails_helper'

describe CurrencyPairsController do
  describe "GET index" do
    it "should return success response" do
      currency_pairs = double
      allow(CurrencyPairService).to receive(:get_all).and_return(currency_pairs)
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    it "should return success response" do
      currency_pair = double
      allow(CurrencyPairService).to receive(:create).and_return(currency_pair)
      post :create, params: { currency_pair: { from: 'USD', to: 'IDR' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE destroy" do
    it "should return success response" do
      currency_pair = double
      allow(CurrencyPairService).to receive(:delete).and_return(currency_pair)
      delete :destroy, params: { id: 1 }
      expect(response).to have_http_status(:ok)
    end
  end
end
