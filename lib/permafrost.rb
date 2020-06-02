require "English"
require "permafrost/version"

module Permafrost
  module ClassMethods
    def freeze(env = nil, &block) # rubocop:disable Metrics/MethodLength
      reader, writer = IO.pipe
      pid = Process.fork

      if pid.nil?
        reader.close

        freeze_child(writer, env, &block)
      else
        writer.close

        freeze_parent(reader, pid)
      end
    ensure
      reader.close
      writer.close
    end

    def merge(env, &block)
      freeze_env = ENV.to_h.merge(env)

      freeze(freeze_env, &block)
    end

    private

    def freeze_child(write, env)
      ENV.replace(env) unless env.nil?

      yield

      Process.exit!(true)
    rescue StandardError => e
      Marshal.dump(e, write)

      Process.exit!(false)
    end

    def freeze_parent(_reader, child_pid)
      Process.wait(child_pid)

      return if $CHILD_STATUS.exitstatus.zero?

      error_data = read.read
      error = Marshal.load(error_data) # rubocop:disable Security/MarshalLoad

      raise error
    end
  end

  extend ClassMethods
end
