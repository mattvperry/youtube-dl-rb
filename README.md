# youtube-dl

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'youtube-dl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youtube-dl

## Usage
### Options
    -h, --help               print this help text and exit
    --version                print program version and exit
    -U, --update             update this program to latest version
    -i, --ignore-errors      continue on download errors
    -r, --rate-limit LIMIT   download rate limit (e.g. 50k or 44.6m)
    -R, --retries RETRIES    number of retries (default is 10)
    --buffer-size SIZE       size of download buffer (e.g. 1024 or 16k) (default
                             is 1024)
    --no-resize-buffer       do not automatically adjust the buffer size. By
                             default, the buffer size is automatically resized
                             from an initial value of SIZE.
    --dump-user-agent        display the current browser identification
    --user-agent UA          specify a custom user agent
    --list-extractors        List all supported extractors and the URLs they
                             would handle

### Video Selection:
    --playlist-start NUMBER  playlist video to start at (default is 1)
    --playlist-end NUMBER    playlist video to end at (default is last)
    --match-title REGEX      download only matching titles (regex or caseless
                             sub-string)
    --reject-title REGEX     skip download for matching titles (regex or
                             caseless sub-string)
    --max-downloads NUMBER   Abort after downloading NUMBER files

### Filesystem Options:
    -t, --title              use title in file name
    --id                     use video ID in file name
    -l, --literal            [deprecated] alias of --title
    -A, --auto-number        number downloaded files starting from 00000
    -o, --output TEMPLATE    output filename template. Use %(title)s to get the
                             title, %(uploader)s for the uploader name,
                             %(uploader_id)s for the uploader nickname if
                             different, %(autonumber)s to get an automatically
                             incremented number, %(ext)s for the filename
                             extension, %(upload_date)s for the upload date
                             (YYYYMMDD), %(extractor)s for the provider
                             (youtube, metacafe, etc), %(id)s for the video id
                             and %% for a literal percent. Use - to output to
                             stdout. Can also be used to download to a different
                             directory, for example with -o '/my/downloads/%(upl
                             oader)s/%(title)s-%(id)s.%(ext)s' .
    --restrict-filenames     Restrict filenames to only ASCII characters, and
                             avoid "&" and spaces in filenames
    -a, --batch-file FILE    file containing URLs to download ('-' for stdin)
    -w, --no-overwrites      do not overwrite files
    -c, --continue           resume partially downloaded files
    --no-continue            do not resume partially downloaded files (restart
                             from beginning)
    --cookies FILE           file to read cookies from and dump cookie jar in
    --no-part                do not use .part files
    --no-mtime               do not use the Last-modified header to set the file
                             modification time
    --write-description      write video description to a .description file
    --write-info-json        write video metadata to a .info.json file

### Verbosity / Simulation Options:
    -q, --quiet              activates quiet mode
    -s, --simulate           do not download the video and do not write anything
                             to disk
    --skip-download          do not download the video
    -g, --get-url            simulate, quiet but print URL
    -e, --get-title          simulate, quiet but print title
    --get-thumbnail          simulate, quiet but print thumbnail URL
    --get-description        simulate, quiet but print video description
    --get-filename           simulate, quiet but print output filename
    --get-format             simulate, quiet but print output format
    --no-progress            do not print progress bar
    --console-title          display progress in console titlebar
    -v, --verbose            print various debugging information

### Video Format Options:
    -f, --format FORMAT      video format code
    --all-formats            download all available video formats
    --prefer-free-formats    prefer free video formats unless a specific one is
                             requested
    --max-quality FORMAT     highest quality format to download
    -F, --list-formats       list all available formats (currently youtube only)
    --write-srt              write video closed captions to a .srt file
                             (currently youtube only)
    --srt-lang LANG          language of the closed captions to download
                             (optional) use IETF language tags like 'en'

### Authentication Options:
    -u, --username USERNAME  account username
    -p, --password PASSWORD  account password
    -n, --netrc              use .netrc authentication data

### Post-processing Options:
    -x, --extract-audio      convert video files to audio-only files (requires
                             ffmpeg or avconv and ffprobe or avprobe)
    --audio-format FORMAT    "best", "aac", "vorbis", "mp3", "m4a", "opus", or
                             "wav"; best by default
    --audio-quality QUALITY  ffmpeg/avconv audio quality specification, insert a
                             value between 0 (better) and 9 (worse) for VBR or a
                             specific bitrate like 128K (default 5)
    --recode-video FORMAT    Encode the video to another format if necessary
                             (currently supported: mp4|flv|ogg|webm)
    -k, --keep-video         keeps the video file on disk after the post-
                             processing; the video is erased by default
    --no-post-overwrites     do not overwrite post-processed files; the post-
                             processed files are overwritten by default

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
