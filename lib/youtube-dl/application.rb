require 'optparse'
require 'ostruct'

module Youtube
  class Application
    def run
      parse_options
    end

    def options
      @options ||= OpenStruct.new
    end

    private
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
          ['--version', 'print program version and exit',
            ->(_) { puts Youtube::VERSION; exit }
          ],
          ['-i', '--ignore-errors', 'continue on download errors',
            ->(value) { options.ignore_errors = value }
          ],
          ['-r', '--rate-limit LIMIT', 'download rate limit (e.g. 50k or 44.6m)',
            ->(value) { options.rate_limit = value }
          ],
          ['-R', '--retries RETRIES', Integer, "number of retries (default is #{options.retries})",
            ->(value) { options.retries = value }
          ],
          ['--buffer-size SIZE', "size of download buffer (e.g. 1024 or 16k) (default is #{options.buffer_size})",
            ->(value) { options.buffer_size = value }
          ],
          ['--no-resize-buffer', 'do not automatically adjust the buffer size. By default, the buffer size is automatically resized from an initial value of SIZE.',
            ->(value) { options.no_resize_buffer = value }
          ],
          ['--dump-user-agent', 'display the current browser identification',
            ->(value) { options.dump_user_agent = value }
          ],
          ['--user-agent UA', 'specify a custom user agent',
            ->(value) { options.user_agent = value }
          ],
          ['--list-extractors', 'List all supported extractors and the URLs they would handle',
            ->(value) { } # TODO
          ]
        ],
        "Video Selection:" =>
        [
          ['--playlist-start NUMBER', Integer, "playlist video to start at (default is #{options.playlist_start})",
            ->(value) { options.playlist_start = value }
          ],
          ['--playlist-end NUMBER', Integer, "playlist video to end at (default is #{options.playlist_end})",
            ->(value) { options.playlist_end = value }
          ],
          ['--match-title REGEX', 'download only matching titles (regex or caseless sub-string)',
            ->(value) { options.match_title = value }
          ],
          ['--reject-title REGEX', 'skip download for matching titles (regex or caseless sub-string)',
            ->(value) { options.reject_title = value }
          ],
          ['--max-downloads NUMBER', Integer, 'Abort after downloading NUMBER files',
            ->(value) { options.max_downloads = value }
          ]
        ],
        "Filesystem Options:" =>
        [
          ['-t', '--title', 'use title in file name',
            ->(value) { options.use_title = value }
          ],
          ['--id', 'use video ID in file name',
            ->(value) { options.use_id = value }
          ],
          ['-A', '--auto-number', 'number downloaded files starting from 00000',
            ->(value) { options.auto_number = value }
          ],
          ['-o', '--output TEMPLATE', "output filename template. The following format strings are supported: %(title)s, %(uploader)s, %(uploader_id)s, %(autonumber)s, %(ext)s, %(upload_date)s, %(extractor)s, %(id)s. Use - to output to stdout.",
            ->(value) { options.output_template = value }
          ],
          ['--restrict-filenames', 'Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames',
            ->(value) { options.restrict_filenames = value }
          ],
          ['-a', '--batch-file FILE', 'file containing URLs to download ("-" for stdin)',
            ->(value) { options.batch_file = value }
          ],
          ['-w', '--no-overwrites', 'do not overwrite files',
            ->(value) { options.no_overwrites = value }
          ],
          ['-c', '--[no-]continue', 'toggle resuming partially downloaded files',
            ->(value) { options.continue = value }
          ],
          ['--cookies FILE', 'file to read cookies from and dump cookie jar in',
            ->(value) { options.cookies_file = value }
          ],
          ['--no-part', 'do not use .part files',
            ->(value) { options.no_part = value }
          ],
          ['--no-mtime', 'do not use Last-modified header to set the file modification time',
            ->(value) { options.no_mtime = value }
          ],
          ['--write-description', 'write video description to a .description file',
            ->(value) { options.write_description = value }
          ],
          ['--write-info-json', 'write video metadata to a .info.json file',
            ->(value) { options.write_info_json = value }
          ]
        ],
        "Verbosity / Simulation Options:" =>
        [
          ['-q', '--quiet', 'activates quiet mode',
            ->(value) { options.quiet_mode = value }
          ],
          ['-s', '--simulate', 'do not download the video and do not write anything to disk',
            ->(value) { options.simulate = value }
          ],
          ['--skip-download', 'do not download the video',
            ->(value) { options.skip_download = value }
          ],
          ['-g', '--get-url', 'simulate, quiet but print URL',
            ->(value) { options.get_url = value }
          ],
          ['-e', '--get-title', 'simulate, quiet but print title',
            ->(value) { options.get_title = value }
          ],
          ['--get-thumbnail', 'simulate, quiet but print thumbnail URL',
            ->(value) { options.get_thumbnail = value }
          ],
          ['--get-description', 'simulate, quite but print video description',
            ->(value) { options.get_description = value }
          ],
          ['--get-filename', 'simulate, quite but print output filename',
            ->(value) { options.get_filename = value }
          ],
          ['--get-format', 'simulate, quiet but print output format',
            ->(value) { options.get_format = value }
          ],
          ['--no-progress', 'do not print progress bar',
            ->(value) { options.no_progress = value }
          ],
          ['--console-title', 'display progress in console titlebar',
            ->(value) { options.console_title = value }
          ],
          ['-v', '--verbose', 'print various debugging information',
            ->(value) { options.verbose = value }
          ]
        ],
        "Video Format Options:" =>
        [
          ['-f', '--format FORMAT', 'video format code',
            ->(value) { options.format = value }
          ],
          ['--all-formats', 'download all available video formats',
            ->(value) { options.all_formats = value }
          ],
          ['--prefer-free-formats', 'prefer free video formats unless a specific one is requested',
            ->(value) { options.prefer_free_formants = value }
          ],
          ['--max-quality FORMAT', 'highest quality to download',
            ->(value) { options.max_quality = value }
          ],
          ['-F', '--list-formats', 'list all available formats (currently youtube only)',
            ->(value) { options.list_formats = value }
          ],
          ['--write-srt', 'write video closed captions to a .srt file (currently youtube only)',
            ->(value) { options.write_srt = value }
          ],
          ['--srt-lang LANG', 'language of the closed captions to download (optional) use IETF language tags like "en"',
            ->(value) { options.srt_lang = value }
          ]
        ],
        "Authentication Options:" =>
        [
          ['-u', '--username USERNAME', 'account username',
            ->(value) { options.username = value }
          ],
          ['-p', '--password PASSWORD', 'account password',
            ->(value) { options.password = password }
          ],
          ['-n', '--netrc', 'use .netrc authentication data',
            ->(value) { options.netrc = value }
          ]
        ],
        "Post-processing Options:" =>
        [
          ['-x', '--extract-audio', 'convert video files to audio-only files (requires ffmpeg or avconv and ffprobe or avprobe)',
            ->(value) { options.extract_audio = value }
          ],
        ]
      }
    end

    def parse_options
      set_default_options

      OptionParser.new do |opts|
        opts.banner = 'youtube-dl [options] url [url...]'
        opts.separator ""

        opts.on_tail("-h", "--help", "print this help text and exit") do
          puts opts
          exit
        end

        standard_options.each do |key, value|
          opts.separator key
          value.each { |args| opts.on(*args) }
          opts.separator ""
        end
      end.parse!
    end
  end
end
