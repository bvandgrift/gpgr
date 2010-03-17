=begin

  gpgr is a very light interface to the command-line GPG (GNU 
  Privacy Guard) tool which is soley concerned with making it
  as easy as possible to encrypt files with one (or more) public
  keys.

  It does not provide any major key management tools and does not
  support decryption.   

  Usage:
    
    require 'rubygems'
    require 'gpgr'
    list_of_keys = [ 'foo@example.com', 'bar@example.com' ]
    
    File.open('encrupted_file.gpg', 'w') do |f|
      f.write Gpgr::Encrypt.file('/some_file.txt').using(list_of_keys).go
    end

=end
module Gpgr

  def self.command
    '/usr/bin/env gpg'
  end

  module Encrypt

    def self.file(path)
      puts File.expand_path(path)
    end

  end


  module Keys

    # Imports the key at the specified path into the keyring. Since this is
    # really running gpg --import ./path/to/key.asc, the key will be imported
    # and added to the keyring for the user executing this command.
    #
    def self.import(path_to_key)
      Gpgr.command + " --yes --import #{File.expand_path(path_to_key)}"
    end

    # Iterates through all of the files at a specified path and attempts to import
    # those which are likely to be GPG / PGP Public Keys.
    # 
    def self.import_keys_at(path)
      Dir.each '/path' do |file|
        Gpgr::Keys.import(file)
      end
    end

  end

end