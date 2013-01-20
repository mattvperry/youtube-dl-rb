require "youtube-dl/version"
require "youtube-dl/application"

module Youtube
  def self.application
    @application ||= Youtube::Application.new
  end
end
