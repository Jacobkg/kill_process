require_relative '../lib/kill_process'
require 'benchmark'

describe "Killing Process" do

  it "times out" do
    if child = Kernel.fork
      elapsed = Benchmark.realtime do
        Process.waitpid(child)
      end
      expect(elapsed).to be_within(0.1).of(2)
    else
      KillProcess.after(2)
      sleep 5
    end
  end

end