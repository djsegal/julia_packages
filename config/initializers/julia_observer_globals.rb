@metadata_directory = 'tmp/METADATA.jl'
@github_directory = 'tmp/github'
@scour_directory = 'tmp/scour'

class StubbedBar
  attr_accessor :bar

  def initialize
    bar_object = super
    self.bar = RakeProgressbar.new(2)
    self.bar.inc
    puts ""

    bar_object
  end

  def inc
    return
  end

  def finished
    self.bar.finished
    puts ""
  end
end

def make_progress_bar bar_count
  return StubbedBar.new \
    if Rails.env.production?

  RakeProgressbar.new bar_count
end
