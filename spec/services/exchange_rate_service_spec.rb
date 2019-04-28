require 'rails_helper'

describe ExchangeRateService do
  it "should create an exchange rate" do
    currency_pair_double = double('CurrencyPair', :id => 1, :from => 'USD', :to => 'IDR')
    exchange_rate_double = double('ExchangeRate', :id => 1, :currency_pair_id => 1, :date => '2019-01-01', :rate => 1.2345)
    params = { date: '2019-01-01', rate: 1.2345 }

    allow(CurrencyPairService).to receive(:get_by_currency).with('USD', 'IDR').and_return(currency_pair_double)
    allow(currency_pair_double).to receive_message_chain(:exchange_rates, :create).with(params).and_return(exchange_rate_double)

    exchange_rate = ExchangeRateService.create('USD', 'IDR', params)
    expect(exchange_rate.date).to eq('2019-01-01')
    expect(exchange_rate.rate).to eq(1.2345)
  end

  it "should get exchange rates trend" do
    currency_pair_double = double('CurrencyPair', :id => 1, :from => 'USD', :to => 'IDR')

    exchange_rates_double = []
    exchange_rates_double.push(double('ExchangeRate', :id => 1, :currency_pair_id => 1, :date => '2019-01-01', :rate => 1.0))
    exchange_rates_double.push(double('ExchangeRate', :id => 2, :currency_pair_id => 1, :date => '2019-01-02', :rate => 2.0))
    exchange_rates_double.push(double('ExchangeRate', :id => 3, :currency_pair_id => 1, :date => '2019-01-03', :rate => 3.0))
    exchange_rates_double.push(double('ExchangeRate', :id => 4, :currency_pair_id => 1, :date => '2019-01-04', :rate => 4.0))
    exchange_rates_double.push(double('ExchangeRate', :id => 5, :currency_pair_id => 1, :date => '2019-01-05', :rate => 5.0))
    exchange_rates_double.push(double('ExchangeRate', :id => 6, :currency_pair_id => 1, :date => '2019-01-06', :rate => 6.0))
    exchange_rates_double.push(double('ExchangeRate', :id => 7, :currency_pair_id => 1, :date => '2019-01-07', :rate => 7.0))

    allow(CurrencyPairService).to receive(:get_by_currency).with('USD', 'IDR').and_return(currency_pair_double)
    allow(currency_pair_double).to receive_message_chain(:exchange_rates, :order, :take).and_return(exchange_rates_double)

    trend = ExchangeRateService.get_trend('USD', 'IDR', 7)
    expect(trend[:average]).to eq(4.0)
    expect(trend[:variance]).to eq(6.0)
    expect(trend[:exchange_rates].size).to eq(7)
  end

  it "should get tracked exchange rates" do
    currency_pair_one = CurrencyPair.new(id: 1, from: 'USD', to: 'GBP')
    currency_pair_two = CurrencyPair.new(id: 2, from: 'USD', to: 'EUR')

    currency_pairs_double = []
    currency_pairs_double.push(currency_pair_one)
    currency_pairs_double.push(currency_pair_two)

    exchange_rates_double_one = []
    exchange_rates_double_one.push(double('ExchangeRate', :id => 1, :currency_pair_id => 1, :date => '2019-01-01', :rate => 1.0))
    exchange_rates_double_one.push(double('ExchangeRate', :id => 2, :currency_pair_id => 1, :date => '2019-01-02', :rate => 2.0))
    exchange_rates_double_one.push(double('ExchangeRate', :id => 3, :currency_pair_id => 1, :date => '2019-01-03', :rate => 3.0))
    exchange_rates_double_one.push(double('ExchangeRate', :id => 4, :currency_pair_id => 1, :date => '2019-01-04', :rate => 4.0))
    exchange_rates_double_one.push(double('ExchangeRate', :id => 5, :currency_pair_id => 1, :date => '2019-01-05', :rate => 5.0))
    exchange_rates_double_one.push(double('ExchangeRate', :id => 6, :currency_pair_id => 1, :date => '2019-01-06', :rate => 6.0))
    exchange_rates_double_one.push(double('ExchangeRate', :id => 7, :currency_pair_id => 1, :date => '2019-01-07', :rate => 7.0))

    exchange_rates_double_two = []
    exchange_rates_double_two.push(double('ExchangeRate', :id => 8, :currency_pair_id => 2, :date => '2019-01-05', :rate => 5.0))
    exchange_rates_double_two.push(double('ExchangeRate', :id => 9, :currency_pair_id => 2, :date => '2019-01-06', :rate => 6.0))
    exchange_rates_double_two.push(double('ExchangeRate', :id => 10, :currency_pair_id => 2, :date => '2019-01-07', :rate => 7.0))

    allow(CurrencyPairService).to receive(:get_all).and_return(currency_pairs_double)
    allow(currency_pair_one).to receive_message_chain(:exchange_rates, :where).and_return(exchange_rates_double_one)
    allow(currency_pair_one).to receive_message_chain(:exchange_rates, :find_by).and_return(exchange_rates_double_one[6])
    # allow(currency_pair_one).to receive(:[]).and_return(currency_pair_one.from)
    # allow(currency_pair_one).to receive(:[]).with(:to).and_return(currency_pair_one.to)
    allow(currency_pair_two).to receive_message_chain(:exchange_rates, :where).and_return(exchange_rates_double_two)

    track = ExchangeRateService.get_track('2019-01-07')
    expect(track[0][:from]).to eq('USD')
    expect(track[0][:to]).to eq('GBP')
    expect(track[0][:rate]).to eq(7.0)
    expect(track[0][:average]).to eq(4.0)
    expect(track[1][:from]).to eq('USD')
    expect(track[1][:to]).to eq('EUR')
    expect(track[1][:rate]).to eq('insufficient data')
    expect(track[1][:average]).to eq('insufficient data')
  end
end
