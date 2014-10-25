# motion-pusher

A ruby motion wrapper gem to interact with [the pusher cocoapod](https://github.com/lukeredpath/libPusher)

## Installation

Add this line to your application's Gemfile:

    gem 'motion-pusher'

If you are not currently using cocoapods, update your Rakefile

  require 'rubygems'
  require 'motion-cocoapods'

And then execute:

    $ bundle
    $ rake pod:setup
    $ rake pod:install

## Usage

Configure your Rakefile

    app.pusher do
      app.pusher.key = <PUSHER_KEY>
      app.pusher.authorization_url = <AUTH_URL_FOR_PRIVATE_CHANNELS>
    end

And create your first connection

    class PusherClient
      attr_accessor :client

      def initialize
        self.client = MotionPusherClient.new(self)
        client.connect
        channel = client.subscribe_to('cool-public-channel')

        channel.bindToEventNamed('new-message', handleWithBlock: -> (channel_event) {
          puts channel_event.data['message']
        })

      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
