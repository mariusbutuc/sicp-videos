#!/usr/bin/env ruby

SICP_VIDEOS = {
  '1a' => 'Overview and Introduction to Lisp',
  '1b' => 'Procedures and Processes; Substitution Model',
  '2a' => 'Higher-order Procedures',
  '2b' => 'Compound Data',
  '3a' => 'Henderson Escher Example',
  '3b' => 'Symbolic Differentiation; Quotation',
  '4a' => 'Pattern Matching and Rule-based Substitution',
  '4b' => 'Generic Operators',
  '5a' => 'Assignment, State, and Side-effects',
  '5b' => 'Computational Objects',
  '6a' => 'Streams, Part 1',
  '6b' => 'Streams, Part 2',
  '7a' => 'Metacircular Evaluator, Part 1',
  '7b' => 'Metacircular Evaluator, Part 2',
  '8a' => 'Logic Programming, Part 1',
  '8b' => 'Logic Programming, Part 2',
  '9a' => 'Register Machines',
  '9b' => 'Explicit-control Evaluator',
  '10a' => 'Compilation',
  '10b' => 'Storage Allocation and Garbage Collection'
}.freeze

SicpVideo = Struct.new(:id, :title) do
  require 'open-uri'

  attr_accessor :id, :title

  def initialize(id, title)
    @id = id
    @title = title
  end

  def slug
    @slug ||= @title.gsub(/\W+/, '-').downcase
  end

  def url
    @url ||= "http://www.archive.org/download/MIT_Structure_of_Computer_Programs_1986/lec#{@id}_512kb.mp4"
  end

  def srt
    @srt ||= "http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/#{@id}-#{slug}/lec#{@id}_512kb.srt"
  end

  def download_video
    download("out/#{@id}-#{slug}.mp4", url)
  end

  def download_subtitle
    download("out/#{@id}-#{slug}.srt", srt)
  end

  private

  def download(file_out, url)
    File.open(file_out, "wb") do |saved_file|
      open(url, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end
end

SICP_VIDEOS.each_with_index do |(part, title), index|
  video = SicpVideo.new(part, title)

  puts "Downloading #{index+1}/#{SICP_VIDEOS.count}: #{title}"
  video.download_subtitle
  video.download_video
  puts "\t» Done!"
end
