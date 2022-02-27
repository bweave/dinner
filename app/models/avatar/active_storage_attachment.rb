module Avatar
  class ActiveStorageAttachment
    def self.handles?(candidate)
      candidate.attachment_reflections.keys.include?("avatar") &&
        candidate.avatar.attached? &&
        candidate.avatar.variable?
    end

    attr_reader :object, :size

    def initialize(object:, options:)
      @object = object
      @size = options.fetch(:size, 180)
    end

    def avatar_url
      object.avatar.variant(resize_to_fill: [size, size])
    end
  end
end
