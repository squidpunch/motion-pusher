describe MotionPusherClient do
  class PTPusher
    def self.pusherWithKey(key, delegate: delegate, encrypted: encrypted)
      @_fake_key = key
      @_fake_delegate = delegate
      @_fake_encrypted = encrypted
      PTPusher.new
    end

    def self.fake_key
      @_fake_key
    end

    def self.fake_delegate
      @_fake_delegate
    end

    def self.fake_encrypted
      @_fake_encrypted
    end

    def self.fake_connected
      @_fake_connected
    end

    def self.fake_connected=(value)
      @_fake_connected = value
    end

    def self.fake_channel=(value)
      @_fake_channel = value
    end

    def self.fake_channel
      @_fake_channel
    end

    def connect
      self.class.fake_connected = true
    end

    def subscribeToChannelNamed(value)
      self.class.fake_channel = value
    end
    def subscribeToPrivateChannelNamed(value)
      self.class.fake_channel = value
    end
  end

  before do
    @delegate = "some-delegate"
    @client = MotionPusherClient.new(@delegate)
  end

  describe "initialize" do
    it "should pass the delegate to the PTPusher" do
      PTPusher.fake_delegate.should == @delegate
    end

    it "should get the key from your app config" do
      # from app.pusher in Rakefile
      PTPusher.fake_key.should == 'my key'
    end

    it "should default encrypted to true" do
      PTPusher.fake_encrypted.should.be.true
    end
  end

  describe "#connect" do
    it "should connect to pusher" do
      @client.connect
      PTPusher.fake_connected.should.be.true
    end
  end

  describe "#subscribe_to" do
    it "should pass the subscription request to pusher" do
      @client.subscribe_to('test-channel')
      PTPusher.fake_channel.should == 'test-channel'
    end
  end

  describe "#subscribe_to_private" do
    it "should pass the subscription request to pusher" do
      @client.subscribe_to_private('private-test-channel')
      PTPusher.fake_channel.should == 'private-test-channel'
    end
  end
end
