module RbtcArbitrage
  module Clients
    class BtceClient
      include RbtcArbitrage::Client

      def exchange
        :btce
      end

      def balance
        return @balance if @balance
        begin
          balances = interface.get_info["return"]["funds"]
          @balance = [balances["btc"], balances["usd"]]
        rescue NoMethodError => e
          raise SecurityError, "Invalid API key for BTC-e"
        end
      end

      def validate_env
        validate_keys :btce_key, :btce_secret, :btce_address
      end

      def trade action
        opts = {
          type: action,
          rate: price(action),
          amount: @options[:volume],
          pair: "btc_usd"
        }
        interface.trade opts
      end

      def price action
        return @ticker[action.to_s] if @ticker
        @ticker = Btce::Ticker.new("btc_usd").json["ticker"]
        @ticker[action.to_s]
      end

      def transfer client
        if @options[:verbose]
          error = "BTC-E does not have a 'transfer' API.\n"
          error << "You must transfer bitcoin manually."
          @options[:logger].error error
        end
      end

      def interface
        opts = {key: ENV['BTCE_KEY'], secret: ENV['BTCE_SECRET']}
        @interface ||= Btce::TradeAPI.new(opts)
      end
    end
  end
end