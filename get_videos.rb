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
require_relative 'sicp_video'


SICP_VIDEOS.each_with_index do |(part, title), index|
  video = SicpVideo.new(part, title)

  puts "Downloading #{index+1}/#{SICP_VIDEOS.count}: #{title}"
  video.download_subtitle
  video.download_video
  puts "\t» Done!"
end
