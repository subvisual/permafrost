require "permafrost/version"

module Permafrost
  module ClassMethods
    def freeze(env = nil)
      Process.fork do
        ENV.replace(env) unless env.nil?

        yield
      end
    end

    def merge(env, &block)
      freeze_env = ENV.to_h.merge(env)

      freeze(freeze_env, &block)
    end
  end

  extend ClassMethods
end
