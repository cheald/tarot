Settings = Tarot::Config.new(File.join(Rails.root, "config", "tarot.yml"), Rails.env)
def config *args
  Settings.get *args
end
