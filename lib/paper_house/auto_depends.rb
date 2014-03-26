# -*- coding: utf-8 -*-
#
# encoding: utf-8

require 'paper_house/build_failed'
require 'paper_house/safe_popen'

module PaperHouse
  #
  # Automatically detects compilation dependencies.
  #
  class AutoDepends
    attr_reader :data

    def initialize(c_file, o_file, cc, cc_options)
      @cc = cc
      @command = "#{@cc} -H #{cc_options} -c #{c_file} -o #{o_file}"
      @data = []
      @out = STDERR
    end

    #
    # Runs dependency detection.
    #
    def run
      @out.puts @command
      exit_status = popen_command
      fail BuildFailed.new(@command, exit_status) if exit_status != 0
    end

    private

    def popen_command
      SafePopen.popen(@command) do |stdout, stderr, stdin, |
        stdin.close
        parse_cc_h_stderr stderr
      end
    end

    def parse_cc_h_stderr(stderr)
      stderr.each do |each|
        parse_cc_h_stderr_line(each, stderr)
      end
    end

    def parse_cc_h_stderr_line(line, stderr)
      case line
      when /^\./
        extract_header_path_from line
      when /Multiple include guards/
        filter_out_include_guards_warnings stderr
      else
        @out.puts line
      end
    end

    def extract_header_path_from(line)
      @data << line.sub(/^\.+\s+/, '').strip
    end

    private

    def filter_out_include_guards_warnings(stderr)
      stderr.each_line do |each|
        next unless each =~ /:$/
        @out.puts each
        return
      end
    end
  end
end
