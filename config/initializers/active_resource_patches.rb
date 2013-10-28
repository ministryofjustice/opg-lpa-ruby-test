require 'active_resource/validations'  
module ActiveResource
  class Errors# < ActiveModel::Errors
    attr_accessor :raw_hash
    alias_method :unpatched_from_hash, :from_hash
    def from_hash(messages, save_cache = false)
      @raw_hash = ActiveSupport::HashWithIndifferentAccess.new(messages)
      unpatched_from_hash(messages, save_cache = false)
    end
  end
end