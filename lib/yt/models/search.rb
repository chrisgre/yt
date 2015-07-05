require 'yt/models/base'

module Yt
  module Models
    class Search < Base
      attr_reader :id, :snippet, :data, :kind, :channel_title

      # @!attribute [r] title
      #   @return [String] the channel’s title.
      delegate :title, to: :snippet

      # @!attribute [r] description
      #   @return [String] the channel’s description.
      delegate :description, to: :snippet

      # @!method thumbnail_url(size = :default)
      #   Returns the URL of the channel’s thumbnail.
      #   @param [Symbol, String] size The size of the channel’s thumbnail.
      #   @return [String] if +size+ is +default+, the URL of a 88x88px image.
      #   @return [String] if +size+ is +medium+, the URL of a 240x240px image.
      #   @return [String] if +size+ is +high+, the URL of a 800x800px image.
      #   @return [nil] if the +size+ is not +default+, +medium+ or +high+.
      delegate :thumbnail_url, to: :snippet

      def initialize(options={})
        @data = options[:data]
        @snippet = Snippet.new(data: @data['snippet'])
        @channel_title = @data['snippet']['channelTitle']
        @kind = @data['id']['kind'].split('#').last
        @id = @data['id']["#{@kind}Id"]
      end

      def channel?
        self.kind == 'channel'
      end

      def video?
        self.kind == 'video'
      end
      
    end
  end
end