class ExchangeRateService
  def self.create(from, to, params)
    currency_pair = CurrencyPairService.get_by_currency(from, to)
    currency_pair.exchange_rates.create(params)
  end

  def self.get_trend(from, to, days)
    currency_pair = CurrencyPairService.get_by_currency(from, to)
    exchange_rates = currency_pair.exchange_rates.order(date: :desc).take(days)

    average = exchange_rates.sum(&:rate) / exchange_rates.size
    variance = exchange_rates.max_by(&:rate).rate - exchange_rates.min_by(&:rate).rate

    { average: average, variance: variance, exchange_rates: exchange_rates }
  end

  def self.get_track(date)
    date = date.to_date
    result = []

    currency_pairs = CurrencyPairService.get_all
    currency_pairs.each do |currency_pair|
      exchange_rates = currency_pair.exchange_rates.where('date BETWEEN ? AND ?', date - 6.days, date)
      if exchange_rates.size < 7
        rate = 'insufficient data'
        average = 'insufficient data'
      else
        rate = currency_pair.exchange_rates.find_by(date: date).rate
        average = exchange_rates.sum(&:rate) / exchange_rates.size
      end
      result.push({ from: currency_pair[:from], to: currency_pair[:to], rate: rate, average: average })
    end

    result
  end
end
