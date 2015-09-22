def secret_token
  token_file = Rails.root.join('.secret')
  if File.exists?(token_file)
    File.read(token_file).chomp
  else
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Skillgrid::Application.config.secret_key_base = secret_token
