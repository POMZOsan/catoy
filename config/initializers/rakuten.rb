RakutenWebService.configure do |c|
  c.application_id = Rails.application.credentials.rakuten[:application_id].to_s
end