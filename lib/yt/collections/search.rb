# encoding: UTF-8
require 'yt/collections/base'

module Yt
  module Collections
    class Search < Base
      def where(requirement = {})
        super
      end

      def next_page_token
        @last_response.body['nextPageToken'] if @last_response
      end

      private

      def list_params
        super.tap{|params| params[:params] = search_params }
      end

      def search_params
        params = { part: 'snippet', max_results: 10 }
        apply_where_params! params
      end
    end
  end
end