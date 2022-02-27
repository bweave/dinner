module Avatar
  class Email
    include Gravatar

    def self.handles?(candidate)
      candidate.has_attribute?(:email)
    end

    def initialize(object:, options:)
      super
      @gravatar_id = Digest::MD5.hexdigest(object.email.downcase)
    end
  end
end
