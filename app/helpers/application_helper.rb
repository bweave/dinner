module ApplicationHelper
  def avatar_path(object, options = {})
    size = options[:size] || 180
    default_image = options[:default] || "mp"
    base_url =  "https://secure.gravatar.com/avatar"
    base_url_params = "?s=#{size}&d=#{default_image}"

    if object.respond_to?(:avatar) && object.avatar.attached? && object.avatar.variable?
      object.avatar.variant(resize_to_fill: [size, size])
    elsif object.respond_to?(:email) && object.email
      gravatar_id = Digest::MD5::hexdigest(object.email.downcase)
      "#{base_url}/#{gravatar_id}#{base_url_params}"
    else
      "#{base_url}/00000000000000000000000000000000#{base_url_params}"
    end
  end

  def bootstrap_flash_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-primary"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
