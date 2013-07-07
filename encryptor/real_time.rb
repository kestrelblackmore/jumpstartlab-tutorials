require_relative 'encryptor'

class RealTime

  def initialize(encryptor, rotation)
    @encryptor = encryptor
    @rotation = rotation
  end

  def interactive_encrypt
    data = gets.chomp
    puts @encryptor.encrypt(data, @rotation)
  end

  def interactive_decrypt
    data = gets.chomp
    puts @encryptor.decrypt(data, @rotation)
  end
end