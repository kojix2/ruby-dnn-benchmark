# frozen_string_literal: true

require 'stackprof'
require 'optparse'

opt = ARGV.getopts('g', 'gpu', 'out:')

if opt['g'] || opt['gpu']
  puts 'Use Cumo'
  require 'cumo'

  # https://github.com/sonots/cumo/issues/143
  SFloat = Cumo::SFloat
  class SFloat
    alias mean_original mean
    def mean(*args)
      if size == 1
        self[0]
      else
        mean_original(*args)
      end
    end
  end

else
  puts 'Use Numo'
  require 'numo/linalg'
  SFloat = Numo::SFloat
end

if opt['out']
  StackProf.run(mode: :cpu, out: opt['out'], raw: true) do
    load './mnist_example_for_profiler.rb'
  end
else
  load './mnist_example_for_profiler.rb'
end
