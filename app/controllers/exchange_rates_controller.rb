class ExchangeRatesController < ApplicationController
  protect_from_forgery prepend: true

  def create
    exchange_rate = ExchangeRateService.create(params[:from], params[:to], exchange_rate_params)
    render json: exchange_rate, status: :ok
  end

  def trend
    trend = ExchangeRateService.get_trend(params[:from], params[:to], params[:days])
    render json: trend, status: :ok
  end

  def track
    track = ExchangeRateService.get_track(params[:date])
    render json: track, status: :ok
  end

  private
  def exchange_rate_params
    params.require(:exchange_rate).permit(:date, :rate)
  end
end
