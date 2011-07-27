require "tarot/version"
require "active_support/core_ext"

module Tarot
  class Config
    attr_accessor :config_files, :yaml, :env
    def initialize(files, env)
      @config_files = files
      @config_files = [@config_files] if @config_files.is_a? String
      @yaml = {}
      yaml = "---\n" + @config_files.map do |file|
        File.open(file).read.untaint.gsub(/^---.*$/, '')
      end.join("\n")
      @yaml = YAML::load(yaml).stringify_keys!
      @config_files.each do |file|
        yaml = YAML::load(open(file).read).stringify_keys!
        recursive_merge(@yaml, yaml)
      end      
      add_mm @yaml
      @config_cache = {}
      @env = env
    end
    
    def get(key, default = nil, env = @env)
      @config_cache[env] ||= {}
      @config_cache[env][key] ||= key.split('.').inject(@yaml[env || @env]) {|e, part| e.try(:[], part) } || default
    end

    def with_environment(env)
      old_env, self.env = self.env, env
      yield if block_given?
      self.env = old_env
      nil
    end

    private

    def recursive_merge(left, right)
      left.merge!(right) do |key, oldval, newval|
        oldval.class == left.class ? recursive_merge(oldval, newval) : newval
      end
    end

    def add_mm(hsh)
      hsh.instance_eval do
        def method_missing(method, *args)
          self[method.to_s] || args.first
        end
      end

      hsh.each do |key, val|
        if val.class == hsh.class
          add_mm val
        end
      end
    end

    def method_missing(method, *args)
      @yaml[args[1] || @env].send method, *args
    end
  end

  module MethodMissingForHash
    def self.included(obj)
      obj.each do |key, val|
        if obj.class == val.class
          val.extend MethodMissingForHash
        end
      end
    end

  end
end