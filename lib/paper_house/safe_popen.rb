# encoding: utf-8

require 'popen4'

module PaperHouse
  #
  # Thin POpen4 wrapper that avoids POpen4's segraults in 1.8.6.
  # See also https://github.com/engineyard/engineyard/issues/115
  #
  class SafePopen
    #
    # Starts a new process and pass the subprocess IOs and pid to the
    # block supplied.
    #
    def self.popen(command, &block)
      status = nil
      begin
        GC.disable
        status = POpen4.popen4(command, &block)
      ensure
        GC.enable
      end
      status
    end
  end
end
