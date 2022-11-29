require 'excon'
require 'json'

require 'splitwise_api_client/expenses'

module SplitwiseApiClient
  class Client
    include Expenses

    BASE_URL = "https://secure.splitwise.com/api/v3.0"

    def initialize(api_key=ENV['SPLITWISE_API_KEY'])
      @api_key = api_key
    end

    def get(path, query={})
      request = Excon.get(BASE_URL + path, headers: base_headers, query: query)
      resp = JSON.parse(request.body)
      resp
    end

    def post(path, query={}, body={})
      request = Excon.post(BASE_URL + path, headers: base_headers.merge({ 'Content-Type' => 'application/json' }), body: body.to_json)
      resp = JSON.parse(request.body)
      resp
    end

    private

    def base_headers
      {
        'Authorization' => "Bearer #{@api_key}"
      }
    end
  end
end
