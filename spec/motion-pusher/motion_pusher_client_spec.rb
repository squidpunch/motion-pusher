describe MotionPusherClient do
  class FakePTPusher
    def isConnected; true; end
    def socketID; 1; end
  end

  class PTPusherChannel
    attr_accessor :unsubscribe_called
    def unsubscribe
      self.unsubscribe_called = true
    end
  end
  class PTPusher
    attr_accessor :subscribed_to
    attr_accessor :fake_connection

    def connect
      self.fake_connection = FakePTPusher.new
    end

    def connection
      self.fake_connection
    end

    def subscribeToChannel(channel)
      self.subscribed_to ||= []
      subscribed_to << channel
    end
  end

  before do
    @delegate = "some-delegate"
    @client = MotionPusherClient.new(@delegate)
  end

  describe "initialize" do
    it "should pass the delegate to the PTPusher" do
      @client.client.delegate.should == @delegate
    end
  end

  describe "#connect" do
    it "should connect the client" do
      @client.connect

      @client.client.fake_connection.should.not.be.nil
    end
  end

  describe "#subscribe_to" do
    before do
      @client.connect
    end
    it "should return the channel to the caller" do
      @client.subscribe_to('test-subscribe').is_a?(PTPusherChannel).should.be.true
    end
    it "should be the channel we requested" do
      @client.subscribe_to('test-subscribe').name.should == "test-subscribe"
    end

    it "should subscribe to the channel" do
      channel = @client.subscribe_to('test-subscribe')
      @client.client.subscribed_to.include?(channel).should.be.true
    end
  end

  describe "#subscribe_to" do
    before do
      @client.connect
    end
    it "should return the channel to the caller" do
      @client.subscribe_to_private('test-subscribe').is_a?(PTPusherChannel).should.be.true
    end
    it "should be the channel we requested" do
      @client.subscribe_to_private('test-subscribe').name.should == "private-test-subscribe"
    end

    it "should subscribe to the channel" do
      channel = @client.subscribe_to_private('test-subscribe')
      @client.client.subscribed_to.include?(channel).should.be.true
    end
  end

  describe "#unsubscribe_from" do
    before do
      @client.connect
      @channel = @client.subscribe_to('test-subscribe')
    end

    context "when passing a channel object" do
      it "should unsubscribe from the channel" do
        @client.unsubscribe_from(@channel)

        @channel.unsubscribe_called.should.be.true
      end
    end

    context "when passing a string name for a channel" do
      it "should unsubscribe from the channel" do
        @client.unsubscribe_from('test-subscribe')

        @channel.unsubscribe_called.should.be.true
      end
    end
  end
end
