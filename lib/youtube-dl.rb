require "youtube-dl/version"
require "youtube-dl/application"

module Youtube
  HEADERS = {
    'User-Agent' => 'Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20100101 Firefox/10.0',
    'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.7',
    'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Encoding' => 'gzip, deflate',
    'Accept-Language' => 'en-us,en;q=0.5',
  }

  def self.application
    @application ||= Youtube::Application.new
  end
end
