class CurrencyPairsController < ApplicationController
  protect_from_forgery prepend: true

  def index
    currency_pairs = CurrencyPair.all
    render json: currency_pairs, status: :ok
  end

  def create
    currency_pair = CurrencyPair.create(currency_pair_params)
    render json: currency_pair, status: :ok
  end

  def destroy
    currency_pair = CurrencyPair.find(params[:id])
    currency_pair.destroy
    render json: currency_pair, status: :ok
  end

  private
  def currency_pair_params
    params.require(:currency_pair).permit(:from, :to)
  end
end
