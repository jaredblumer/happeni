class PostmarkEmailService
  attr_reader :client

  def initialize
    @client = Postmark::ApiClient.new(ENV["POSTMARK_API_KEY"])
  end
end
