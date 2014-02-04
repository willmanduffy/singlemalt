module Postable
  extend ActiveSupport::Concern

  included do
    after_create :send_post, if: :facebook?
  end

  private

  def send_post
    Facebook.instance.post self.form_facebook_message
  end
end