require 'mkmf'

abort "missing rt library" unless have_library('rt')
create_makefile 'itimer_native'