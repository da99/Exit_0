require 'Exit_0/version'
require 'Split_Lines'
require 'posix/spawn'

def Exit_0 *cmd, &blok
  
  both = !cmd.empty? && block_given?
  raise ArgumentError, "Both command and block are not allowed." if both

  if block_given?
    cmd = blok
    r = p = blok.call
    msg = cmd
  else
    r = p = Exit_0::Child.new(*cmd)
    msg = p.err.strip.empty? ? p.cmd : p.err
    msg << " (command: #{cmd})"
  end


  (r = r.status) if r.respond_to?(:status)
  raise(Exit_0::Unknown_Exit, msg.inspect) unless r.respond_to?(:exitstatus)
  raise(Exit_0::Non_0, "#{r.exitstatus} => #{msg}") if r.exitstatus != 0

  p
end # === Exit_0

def Exit_Zero *cmd, &blok
  Exit_0 *cmd, &blok
end

class Exit_0
  
  Non_0      = Class.new(RuntimeError)
  Unknown_Exit  = Class.new(RuntimeError)
  
  module Class_Methods
  end # === Class_Methods
  
  extend Class_Methods
  
  class Child
    module Base
      
      attr_reader :cmd, :child
      def initialize *cmd
        if cmd[0].is_a?(String)
          
          if cmd[0]["\n"]
            cmd[0] = begin
                       cmd[0]
                       .split("\n")
                       .map(&:strip)
                       .reject(&:empty?)
                       .join(" && ") 
                     end
          end
          
          cmd[0] = "bash -lc #{cmd[0].inspect}"
          
        end
        @child = POSIX::Spawn::Child.new(*cmd)
        @cmd = cmd.join(' ')
      end

      def split_lines
        Split_Lines(child.out)
      end

      %w{ out err }.each { |m|
        eval %~
          def raw_#{m}
            child.#{m}
          end

          def #{m}
            child.#{m}.strip
          end
        ~
      }

      def status
        child.status
      end

    end # === Base
    include Base
  end # === Child
  
end # === class Exit_0
