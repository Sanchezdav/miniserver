require './app/responser.rb'

module Miniserver
  class Application
    def call(env)
      Miniserver::Responser.new(env).()
    end
  end
end
