#!/usr/bin/env ruby

require 'yaml'
require_relative 'sicp_video'

sicp_videos = YAML.load_file('videos.yml')
sicp_videos.each_with_index do |(part, title), index|
  video = SicpVideo.new(part, title)

  puts "Downloading #{index+1}/#{sicp_videos.count}: #{title}"
  video.download_subtitle
  video.download_video
  puts "\t» Done!"
end
