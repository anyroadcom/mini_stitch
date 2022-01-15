require 'json'
require 'rest-client'
require 'mini_stitch/api'
require 'mini_stitch/errors'
require 'mini_stitch/version'

module MiniStitch
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  def self.status
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

  class Configuration
    attr_accessor :token, :client_id

    def initialize
      @token = nil
      @client_id = nil
      @secondary_token = nil
      @secondary_client_id = nil
    end
  end
end
