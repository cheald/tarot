TAROT = Tarot::Config.new(File.join(Rails.root, "config", "tarot.yml"), Rails.env)
def config *args
  TAROT.get *args
end
