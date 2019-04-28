require 'rails_helper'

describe CurrencyPairService do
  it "should return all currency pairs" do
    currency_pairs_double = []
    currency_pairs_double.push(double('CurrencyPair', :id => 1, :from => 'USD', :to => 'IDR'))
    currency_pairs_double.push(double('CurrencyPair', :id => 2, :from => 'USD', :to => 'GBP'))
    currency_pairs_double.push(double('CurrencyPair', :id => 3, :from => 'USD', :to => 'EUR'))
    allow(CurrencyPair).to receive(:all).and_return(currency_pairs_double)

    currency_pairs = CurrencyPairService.get_all
    expect(currency_pairs.size).to eq(3)
  end

  it "should return a currency pair according to the id" do
    currency_pair_double = double('CurrencyPair', :id => 1, :from => 'USD', :to => 'IDR')
    allow(CurrencyPair).to receive(:find).with(1).and_return(currency_pair_double)

    currency_pair = CurrencyPairService.get(1)
    expect(currency_pair.from).to eq('USD')
    expect(currency_pair.to).to eq('IDR')
  end

  it "should return a currency pair according to the currencies" do
    currency_pair_double = double('CurrencyPair', :id => 1, :from => 'USD', :to => 'IDR')
    allow(CurrencyPair).to receive(:find_by).with(from: 'USD', to: 'IDR').and_return(currency_pair_double)

    currency_pair = CurrencyPairService.get_by_currency('USD', 'IDR')
    expect(currency_pair.from).to eq('USD')
    expect(currency_pair.to).to eq('IDR')
  end

  it "should create a currency pair" do
    currency_pair_double = double('CurrencyPair', :id => 1, :from => 'USD', :to => 'IDR')
    allow(CurrencyPair).to receive(:create).with({ from: 'USD', to: 'IDR' }).and_return(currency_pair_double)

    currency_pair = CurrencyPairService.create({ from: 'USD', to: 'IDR' })
    expect(currency_pair.from).to eq('USD')
    expect(currency_pair.to).to eq('IDR')
  end

  it "should delete a currency pair according to the id" do
    currency_pair_double = double('CurrencyPair', :id => 1, :from => 'USD', :to => 'IDR')
    allow(CurrencyPair).to receive(:find).with(1).and_return(currency_pair_double)
    allow(currency_pair_double).to receive(:destroy).and_return(currency_pair_double)

    currency_pair = CurrencyPairService.delete(1)
    expect(currency_pair.from).to eq('USD')
    expect(currency_pair.to).to eq('IDR')
  end
end
