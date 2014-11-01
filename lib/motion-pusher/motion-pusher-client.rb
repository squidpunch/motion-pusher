class MotionPusherClient
  def initialize(delegate)
    self.client = PTPusher.pusherWithKey(
      self.config['key'],
      delegate: delegate,
      encrypted: true
    )
  end

  def connect
    client.connect
  end

  def subscribe_to(channel)
    client.subscribeToChannelNamed(channel)
  end

  def subscribe_to_private(channel)
    client.subscribeToPrivateChannelNamed(channel)
  end

  def subscribe_to_presence(channel)
    client.subscribeToPresenceChannelNamed(channel)
  end

  def unsubscribe_from(channel)
    channel = self.client.channelNamed(channel) if channel.is_a? String
    channel.unsubscribe if channel
  end

  def config
    @config ||= NSBundle.mainBundle.objectForInfoDictionaryKey('MotionPusher')
  end

  private

  attr_accessor :client
end
