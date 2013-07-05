class Encryptor

  def decrypt(string)
    encrypt(string)
  end

  def encrypt(string)

    # do encryption
    results = string.split("").collect do |letter|
      encrypt_letter(letter)
    end

    results.join

  end

  def encrypt_letter(letter)
    cipher[letter.downcase]
  end

  def cipher
    {'a' => 'n', 'b' => 'o', 'c' => 'p', 'd' => 'q',
     'e' => 'r', 'f' => 's', 'g' => 't', 'h' => 'u',
     'i' => 'v', 'j' => 'w', 'k' => 'x', 'l' => 'y',
     'm' => 'z', 'n' => 'a', 'o' => 'b', 'p' => 'c',
     'q' => 'd', 'r' => 'e', 's' => 'f', 't' => 'g',
     'u' => 'h', 'v' => 'i', 'w' => 'j', 'x' => 'k',
     'y' => 'l', 'z' => 'm'}
  end



end