require 'rails_helper'

describe ExchangeRatesController do
  describe "POST create" do
    it "should return success response" do
      exchange_rate = double
      allow(ExchangeRateService).to receive(:create).and_return(exchange_rate)
      post :create, params: { from: 'USD', to: 'IDR', exchange_rate: { date: '2019-01-01', rate: '1.2345' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET trend" do
    it "should return success response" do
      trend = double
      allow(ExchangeRateService).to receive(:get_trend).and_return(trend)
      get :trend, params: { from: 'USD', to: 'IDR', days: 7 }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET track" do
    it "should return success response" do
      track = double
      allow(ExchangeRateService).to receive(:get_track).and_return(track)
      get :track, params: { date: '2019-01-01' }
      expect(response).to have_http_status(:ok)
    end
  end
end
