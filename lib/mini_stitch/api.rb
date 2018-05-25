module MiniStitch
  class Api
    attr_accessor :table_name, :sequence, :key_names, :data
    DEFAULT_REQUEST_PARAMS = { content_type: 'application/json', accept: 'json' }.freeze

    def initialize(table_name, sequence, key_names, data)
      validate(key_names, data, table_name)

      @request_params = { Authorization: "Bearer #{MiniStitch.configuration.token}" }.merge(DEFAULT_REQUEST_PARAMS)
      @table_name = table_name
      @sequence = sequence.to_i
      @key_names = key_names.map(&:to_s)
      @data = build_records(data)
    end

    def upsert!
      stitch_post_request("#{base_url}/push")
    end

    def validate!
      stitch_post_request("#{base_url}/validate")
    end

    private

    def build_records(records)
      records.map do |record|
        {
          client_id: MiniStitch.configuration.client_id,
          table_name: table_name,
          sequence: sequence,
          action: default_api_action,
          key_names: key_names,
          data: record
        }
      end
    end

    def base_url
      @api_base_url ||= 'https://api.stitchdata.com/v2/import'.freeze
    end

    def default_api_action
      'upsert'.freeze
    end

    def validate(key_names, data, table_name)
      raise MiniStitch::Errors::WrongUpsertFields, 'key_names field must be an Array' unless key_names.is_a?(Array)
      raise MiniStitch::Errors::WrongUpsertFields, 'data field must be an Array' unless data.is_a?(Array)
      raise MiniStitch::Errors::WrongUpsertFields, 'table_name field must be a String' unless table_name.is_a?(String)
    end

    def stitch_post_request(url)
      JSON.parse(RestClient.post(url, @data.to_json, @request_params))
    rescue RestClient::ExceptionWithResponse => e
      { 'status' => e.message, 'message' => JSON.parse(e.response)['errors'] }
    end
  end
end
