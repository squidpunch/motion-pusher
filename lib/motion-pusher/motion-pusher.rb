unless defined?(Motion::Project::App)
  raise "This must be required from within a RubyMotion Rakefile"
end

class PusherConfig
  attr_accessor :key, :authorization_url

  def initialize(config)
    @config = config
  end

  def key=(value)
    @config.info_plist['MotionPusher'] ||= {}
    @config.info_plist['MotionPusher']['key'] = value
  end

  def authorization_url=(value)
    @config.info_plist['MotionPusher'] ||= {}
    @config.info_plist['MotionPusher']['authorization_url'] = value
  end
end

module Motion
  module Project
    class Config
      variable :pusher

      def pusher
        @pusher ||= PusherConfig.new(self)
        yield @pusher if block_given?
        @pusher
      end
    end
  end
end

Motion::Project::App.setup do |app|
   app.pods ||= Motion::Project::CocoaPods.new(app)
   app.pods.dependency 'libPusher', '~> 1.6'
   app.files.push(File.join(File.dirname(__FILE__), 'motion-pusher-client.rb'))
end
