module Avatar
  module Gravatar
    extend ActiveSupport::Concern

    included do
      attr_reader :gravatar_id, :object, :options
    end

    BASE_URL = "https://secure.gravatar.com/avatar".freeze

    def initialize(object:, options:)
      @object = object
      @options = options
    end

    def size
      options.fetch(:size, 180)
    end

    def default_image
      options.fetch(:default, "mp")
    end

    def avatar_url
      "#{BASE_URL}/#{gravatar_id}?size=#{size}&default=#{default_image}"
    end
  end
end
