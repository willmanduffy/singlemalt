require 'test_helper'

class ThingTest < ActiveSupport::TestCase
  subject { Thing.new }

  # Validations
  must { validate_presence_of(:image) }
  must { validate_presence_of(:name) }
  must { validate_presence_of(:url) }

  must { allow_value('http://www.single-malt.co').for(:url) }

  wont { allow_value('fake-url').for(:url) }

  # Scopes
  describe 'newest_first' do
    before do
      @old = create(:thing)
      @new = create(:thing)
    end

    subject { Thing.newest_first.to_a }

    it 'must return the new thing first' do
      expectation = [@new, @old]

      subject.must_equal expectation
    end
  end

  # Methods
  describe 'form_tweet_message' do
    subject { build_stubbed(:thing, name: 'Pandas!', id: 1001) }

    it 'must properly generate a tweet message' do
      expectation = 'I added a new thing: Pandas! - http://www.single-malt.co/things/1001'

      subject.form_tweet_message.must_equal expectation
    end
  end

  # Behavior
  describe 'set_defaults' do
    subject { build(:thing, tweet: nil).tap(&:valid?) }

    it 'must set the proper defaults' do
      subject.tweet.must_equal false
    end
  end
end
