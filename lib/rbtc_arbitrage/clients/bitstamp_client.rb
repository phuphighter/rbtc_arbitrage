module RbtcArbitrage
  module Clients
    class BitstampClient
      include RbtcArbitrage::Client

      def balance
        return @balance if @balance
        balances = Bitstamp.balance
        @balance = [balances["btc_available"].to_f, balances["usd_available"].to_f]
      end

      def validate_env
        validate_keys :bitstamp_key, :bitstamp_client_id, :bitstamp_secret
        Bitstamp.setup do |config|
          config.client_id = ENV["BITSTAMP_CLIENT_ID"]
          config.key = ENV["BITSTAMP_KEY"]
          config.secret = ENV["BITSTAMP_SECRET"]
        end
      end

      def exchange
        :bitstamp
      end

      def price action
        return @price if @price
        action = {
          buy: :ask,
          sell: :bid,
        }[action]
        @price = Bitstamp.ticker.send(action).to_f
      end

      def trade action
        price(action) unless @price #memoize
        multiple = {
          buy: 1,
          sell: -1,
        }[action]
        bitstamp_options = {
          price: (@price + 0.001 * multiple).to_f.round(2),
          amount: @options[:volume],
        }
        Bitstamp.orders.send(action, bitstamp_options)
      end

      def transfer other_client
        Bitstamp.withdraw_bitcoins({amount: @options[:volume], address: other_client.address})
      end
    end
  end
end