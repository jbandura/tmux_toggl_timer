require 'json'
require 'faraday'

module TmuxTogglTimer
  class TogglFetcher
    def initialize(opts)
      @opts = opts
      @conn = Faraday.new(url: opts[:url], ssl: { verify: true }) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
        faraday.headers = { 'Content-Type' => 'application/json' }
        faraday.basic_auth opts[:api_token], 'api_token'
      end
    end

    def total_time_miliseconds(workspace_id)
      total = @conn.get do |req|
        req.url '/reports/api/v2/details'
        req.params = request_params(workspace_id)
      end

      JSON.parse(total.body)['total_grand']
    end

    def current_entry_data
      response = @conn.get { |req| req.url '/api/v8/time_entries/current' }
      JSON.parse(response.body)['data']
    end

    def project_name(project_id)
      project_response = @conn.get do |req|
        req.url "api/v8/projects/#{project_id}"
      end
      JSON.parse(project_response.body)['data']['name']
    end

    private

    def request_params(workspace_id)
      {
        user_agent: @opts[:user_agent],
        workspace_id: workspace_id,
        user_ids: @opts[:user_id],
        since: Time.now.strftime('%Y-%m-%d')
      }
    end
  end
end
