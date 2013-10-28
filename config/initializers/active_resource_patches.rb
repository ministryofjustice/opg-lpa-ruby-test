require 'active_resource/validations'
module ActiveResource
class Errors
  alias_method :from_hash_without_nesting, :from_hash
  def from_hash(messages, save_cache = false)
    messages.each do |key, errors|
      key = key.to_sym
      if @base.reflections.keys.include?(key)
        if @base.reflections[key].macro == :has_many
          @base.send(key).each_with_index {|o, i| o.errors.from_hash errors[i]}
        elsif @base.reflections[key].macro == :has_one
          @base.send(key).errors.from_hash errors
        end
        messages.delete(key)
      end
    end
    from_hash_without_nesting(messages, save_cache)
  end

  def from_hash_without_nesting(messages, save_cache = false)
    clear unless save_cache

    messages.each do |(key,errors)|
      errors.each do |error|
        if @base.known_attributes.include?(key)
          add key, error
        elsif key == 'base'
          self[:base] << error
        else
          # reporting an error on an attribute not in attributes
          # format and add them to base
          self[:base] << "#{key.humanize} #{error}"
        end
      end
    end
  end

end
end