require 'mkmf'

warn "WARNING: missing rt library" unless have_library('rt')
create_makefile 'kill_process_native'