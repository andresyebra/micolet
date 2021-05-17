class Newsletter < ApplicationRecord
  #Validate if the email is unique in table
  # validates :email, uniqueness: true
  #Validate if the email is valid
  validates :email, :presence => true, :if => :valid_email?

  def valid_email?
    begin
      #Create the URI object that receive the URL API
      uri = URI(ENV['email_validation_api'] + email)
      #Create the Net::HTTP object and set the options
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      request =  Net::HTTP::Get.new(uri)
      response = http.request(request)

      #Convert to json object the body response
      result = JSON.parse(response.body)

      #Valid if email provider it can receive emails
      if result["deliverability"] == "UNDELIVERABLE"
        errors.add(:email, :invalid)
        return false
      end

      #Valid if email provider it has a format valid
      if result["is_valid_format"]["value"] == false
        errors.add(:email, :invalid)
        return false
      end

      #Valid if email provider is free or public also it is a fake or disposable email.
      if result["is_free_email"]["value"] == false && result["is_disposable_email"]["value"] == true
        errors.add(:email, :invalid)
        return false
      end
      true
    rescue StandardError => error
      errors.add(:email, :invalid)
      return false
    end
  end
end
