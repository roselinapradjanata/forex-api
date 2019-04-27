class CurrencyPairService
  def self.get_all
    CurrencyPair.all
  end

  def self.get(id)
    CurrencyPair.find(id)
  end

  def self.get_by_currency(from, to)
    CurrencyPair.find_by(from: from, to: to)
  end

  def self.create(params)
    CurrencyPair.create(params)
  end

  def self.delete(id)
    get(id).destroy
  end
end
