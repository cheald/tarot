require "tarot/version"
require "active_support/core_ext"

module Tarot
  class Config
    attr_accessor :config_file, :yaml, :env
    def initialize(file, env)
      @config_file = file
      @yaml = YAML::load(File.open(file).read.untaint).stringify_keys!
      @config_cache = {}
      @env = env
    end
    
    def get(key, default = nil, env = @env)
      @config_cache[env] ||= {}
      @config_cache[env][key] ||= key.split('.').inject(@yaml[env || @env]) {|e, part| e.try(:[], part) } || default
    end
  end
end