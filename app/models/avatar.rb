module Avatar
  REGISTRY = [
    Avatar::ActiveStorageAttachment,
    Avatar::Email,
    Avatar::Missing,
  ].freeze

  def self.for(object, options = {})
    REGISTRY.find { |candidate| candidate.handles?(object) }.new(object: object, options: options).avatar_url
  end
end
