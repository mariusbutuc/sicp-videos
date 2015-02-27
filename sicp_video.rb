require 'open-uri'

class SicpVideo
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
