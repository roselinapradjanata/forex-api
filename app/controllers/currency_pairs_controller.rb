class CurrencyPairsController < ApplicationController
  protect_from_forgery prepend: true

  def index
    currency_pairs = CurrencyPairService.get_all
    render json: currency_pairs, status: :ok
  end

  def create
    currency_pair = CurrencyPairService.create(currency_pair_params)
    render json: currency_pair, status: :ok
  end

  def destroy
    currency_pair = CurrencyPairService.delete(params[:id])
    render json: currency_pair, status: :ok
  end

  private
  def currency_pair_params
    params.require(:currency_pair).permit(:from, :to)
  end
end
