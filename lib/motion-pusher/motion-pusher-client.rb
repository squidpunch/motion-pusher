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

  def config
    @config ||= NSBundle.mainBundle.objectForInfoDictionaryKey('MotionPusher')
  end

  private

  attr_accessor :client
end
