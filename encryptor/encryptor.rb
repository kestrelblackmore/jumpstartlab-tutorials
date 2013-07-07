class Encryptor
  require 'digest'

  def initialize
    @password = 'b366f9f0e8d13c58ae091bd16242e616'

    while check_password == false do
      puts "Wrong password!"
    end

  end

  def decrypt_file(filename, rotation)
    new_filename = filename.gsub("encrypted", "decrypted")

    decrypted_text = decrypt(get_file_contents(filename), rotation)

    write_to_file(new_filename, decrypted_text)

    puts "Decrypted #{filename} to #{new_filename}."
  end

  def encrypt_file(filename, rotation)
    new_filename = "#{filename}.encrypted"

    encrypted_text = encrypt(get_file_contents(filename), rotation)

    write_to_file(new_filename, encrypted_text)

    puts "Encrypted #{filename} to #{new_filename}."
  end

  def decrypt(string, rotation)
    encrypt(string, rotation * -1)
  end

  def encrypt(string, rotation)
    # do encryption
    results = string.split("").collect do |letter|
      encrypt_letter(letter, rotation)
    end

    results.join
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message, attempt)
    end

  end
  private 

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    
    # zip joins two arrays together. Hash turns them into a true key/value pair
    Hash[characters.zip(rotated_characters)]
  end

  def write_to_file(filename, data)
    output = File.open(filename, "w")
    output.write(data)
    output.close
  end

  def get_file_contents(filename)
    input = File.open(filename, "r")
    contents = input.read
    input.close
    return contents
  end

  def check_password
    puts "Enter the password below."
    encrypted_input = encrypt(gets.chomp, 13)
    md5_input = Digest::MD5.hexdigest(encrypted_input) 
    md5_input == @password
  end

  def supported_characters
    (' '..'z').to_a
  end

end
