require "kill_process/version"

module KillProcess
  require_relative './kill_process_native'

  def self.after(seconds)
     posix_timer_set(seconds)
  end

end
