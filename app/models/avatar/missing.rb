module Avatar
  class Missing
    include Gravatar

    def self.handles?(_candidate)
      true
    end

    def initialize(object:, options:)
      super
      @gravatar_id = "00000000000000000000000000000000"
    end
  end
end
