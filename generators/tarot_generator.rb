require "rails_generator"

module Tarot
  class TarotGenerator < Rails::Generator::Base
    def manifest
      record do |m|
        m.file 'initializer.rb', 'config/initializers/tarot.rb'
        m.file 'config.yml', 'config/tarot.yml'
      end
    end    
  end
end