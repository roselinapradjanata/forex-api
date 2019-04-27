class ExchangeRatesController < ApplicationController
  protect_from_forgery prepend: true

  def create
    currency_pair = CurrencyPair.find_by from: params[:from], to: params[:to]
    exchange_rate = currency_pair.exchange_rates.create(exchange_rate_params)
    render json: exchange_rate, status: :ok
  end

  def trend
    days = params[:days]
    from = params[:from]
    to = params[:to]

    currency_pair = CurrencyPair.find_by(from: from, to: to)
    exchange_rates = currency_pair.exchange_rates.order(date: :desc).take(days)

    average = exchange_rates.sum(&:rate) / exchange_rates.size
    variance = exchange_rates.max_by(&:rate).rate - exchange_rates.min_by(&:rate).rate

    render json: {
        from: from,
        to: to,
        average: average,
        variance: variance,
        exchange_rates: exchange_rates
    }, status: :ok
  end

  def track
    date = params[:date].to_date

    result = []
    currency_pairs = CurrencyPair.all
    currency_pairs.each do |currency_pair|
      exchange_rates = currency_pair.exchange_rates.where('date BETWEEN ? AND ?', date - 6.days, date)
      if exchange_rates.size < 7
        rate = 'insufficient data'
        average = 'insufficient data'
      else
        rate = currency_pair.exchange_rates.find_by(date: date).rate
        average = exchange_rates.sum(&:rate) / exchange_rates.size
      end
      result.push({from: currency_pair[:from], to: currency_pair[:to], rate: rate, average: average})
    end

    render json: result, status: :ok
  end

  private
  def exchange_rate_params
    params.require(:exchange_rate).permit(:date, :rate)
  end
end
