require 'optparse'
require 'ostruct'

module Youtube
  class Application
    def run
      parse_options

      puts options
    end

    def options
      @options ||= OpenStruct.new
    end

    private
    def print_version
      puts Youtube::VERSION
      exit
    end

    def dump_user_agent
      puts HEADERS['User-Agent']
      exit
    end

    def list_extractors
      # TODO
    end

    def set_default_options
      options.retries = 10
      options.buffer_size = 1024
      options.playlist_start = 1
      options.playlist_end = :last
      options.audio_format = :best
    end

    def standard_options
      {
        "General Options:" =>
        [
          ['--version', 'print program version and exit'],
          ['-i', '--ignore-errors', 'continue on download errors'],
          ['-r', '--rate-limit LIMIT', 'download rate limit (e.g. 50k or 44.6m)'],
          ['-R', '--retries RETRIES', Integer, "number of retries (default is #{options.retries})"],
          ['--buffer-size SIZE', "size of download buffer (e.g. 1024 or 16k) (default is #{options.buffer_size})"],
          ['--no-resize-buffer', 'do not automatically adjust the buffer size. By default, the buffer size is automatically resized from an initial value of SIZE.'],
          ['--dump-user-agent', 'display the current browser identification'],
          ['--user-agent UA', 'specify a custom user agent'],
          ['--list-extractors', 'List all supported extractors and the URLs they would handle'],
        ],
        "Video Selection:" =>
        [
          ['--playlist-start NUMBER', Integer, "playlist video to start at (default is #{options.playlist_start})"],
          ['--playlist-end NUMBER', Integer, "playlist video to end at (default is #{options.playlist_end})"],
          ['--match-title REGEX', 'download only matching titles (regex or caseless sub-string)'],
          ['--reject-title REGEX', 'skip download for matching titles (regex or caseless sub-string)'],
          ['--max-downloads NUMBER', Integer, 'Abort after downloading NUMBER files'],
        ],
        "Filesystem Options:" =>
        [
          ['-t', '--title', 'use title in file name'],
          ['--id', 'use video ID in file name'],
          ['-A', '--auto-number', 'number downloaded files starting from 00000'],
          ['-o', '--output TEMPLATE',
            "output filename template. The following format strings are supported: %(title)s, %(uploader)s, %(uploader_id)s, %(autonumber)s, %(ext)s, %(upload_date)s, %(extractor)s, %(id)s. Use - to output to stdout."
          ],
          ['--restrict-filenames', 'Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames'],
          ['-a', '--batch-file FILE', 'file containing URLs to download ("-" for stdin)'],
          ['-w', '--no-overwrites', 'do not overwrite files'],
          ['-c', '--continue', 'resume partially downloaded files'],
          ['--no-continue', 'do not resume partially downloaded files (restart from beggining)'],
          ['--cookies FILE', 'file to read cookies from and dump cookie jar in'],
          ['--no-part', 'do not use .part files'],
          ['--no-mtime', 'do not use Last-modified header to set the file modification time'],
          ['--write-description', 'write video description to a .description file'],
          ['--write-info-json', 'write video metadata to a .info.json file'],
        ],
        "Verbosity / Simulation Options:" =>
        [
          ['-q', '--quiet', 'activates quiet mode'],
          ['-s', '--simulate', 'do not download the video and do not write anything to disk'],
          ['--skip-download', 'do not download the video'],
          ['-g', '--get-url', 'simulate, quiet but print URL'],
          ['-e', '--get-title', 'simulate, quiet but print title'],
          ['--get-thumbnail', 'simulate, quiet but print thumbnail URL'],
          ['--get-description', 'simulate, quiet but print video description'],
          ['--get-filename', 'simulate, quiet but print output filename'],
          ['--get-format', 'simulate, quiet but print output format'],
          ['--no-progress', 'do not print progress bar'],
          ['--console-title', 'display progress in console titlebar'],
          ['-v', '--verbose', 'print various debugging information'],
        ],
        "Video Format Options:" =>
        [
          ['-f', '--format FORMAT', 'video format code'],
          ['--all-formats', 'download all available video formats'],
          ['--prefer-free-formats', 'prefer free video formats unless a specific one is requested'],
          ['--max-quality FORMAT', 'highest quality to download'],
          ['-F', '--list-formats', 'list all available formats (currently youtube only)'],
          ['--write-srt', 'write video closed captions to a .srt file (currently youtube only)'],
          ['--srt-lang LANG', 'language of the closed captions to download (optional) use IETF language tags like "en"'],
        ],
        "Authentication Options:" =>
        [
          ['-u', '--username USERNAME', 'account username'],
          ['-p', '--password PASSWORD', 'account password'],
          ['-n', '--netrc', 'use .netrc authentication data'],
        ],
        "Post-processing Options:" =>
        [
          ['-x', '--extract-audio', 'convert video files to audio-only files (requires ffmpeg or avconv and ffprobe or avprobe)'],
        ]
      }
    end

    def make_setter(args)
      args.find { |a| a.is_a? String and a =~ /--([\w-]*)/ }
      ->(value) { options.send("#{$1.gsub(/-/, '_')}=", value) }
    end

    def parse_options
      set_default_options

      OptionParser.new do |opts|
        opts.banner = "#{opts.program_name} [options] url [url...]"
        opts.separator ""

        opts.on_tail("-h", "--help", "print this help text and exit") do
          puts opts
          exit
        end

        standard_options.each do |key, value|
          opts.separator key
          value.each { |args| opts.on(*args, make_setter(args)) }
          opts.separator ""
        end
      end.parse!
    end
  end
end
