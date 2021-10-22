require 'yaml'

class YamlService
  def get_file_contents
    YAML.load(File.read('./config/poker_hand/base.yml'))
  end
end
