require 'json'
require 'rest-client'
require 'mini_stitch/api'
require 'mini_stitch/errors'
require 'mini_stitch/version'

module MiniStitch
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      configuration ||= Configuration.new
      yield(configuration) if block_given?
    end

    def status
      res = RestClient.get('https://api.stitchdata.com/v2/import/status')

      if res.code == 200
        return {
          status: 200,
          message: "Import API operating correctly on my End ~mj"
        }
      else
        return {
          status: res.code,
          message: JSON.parse(res.body)
        }
      end
    end
  end

  class Configuration
    attr_accessor :token, :client_id

    def initialize
      @token = nil
      @client_id = nil
    end
  end
end
