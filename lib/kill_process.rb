require "kill_process/version"

module KillProcess
  require_relative './kill_process_native'

  def self.after(seconds)
     success = posix_timer_set(seconds)
     if !success
       Kernel.warn "WARNING: KillProcess#after will not do anything because your system does not support POSIX advanced realtime timers"
     end
  end

end
