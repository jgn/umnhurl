require 'fileutils'
require 'couchrest'

module Hurl
  class DB
    ROOT_DIR = File.dirname(File.dirname(File.dirname(File.expand_path(__FILE__))))
    DIR = File.expand_path(ENV['HURL_DB_DIR']) || (ROOT_DIR + "/db")
    dir = File.dirname(File.expand_path(__FILE__))

    def self.couch
      return @couch if @couch
      couch_url = ENV['COUCH_URL']    if !!ENV['COUCH_URL']
      couch_url = ENV['CLOUDANT_URL'] if !!ENV['CLOUDANT_URL']
      if couch_url
        @couch = CouchRest.database(couch_url)
      end
    end

    def self.find(scope, id)
      decode File.read(dir(scope, id) + id) if id && id.is_a?(String)
    rescue Errno::ENOENT
      if self.couch
        self.find_couchdb(scope, id)
      else
        nil
      end
    end

    def self.find_couchdb(scope, id)
      id = [scope, id].join('/')
      self.couch.get(id)['content']
    rescue RestClient::ResourceNotFound
      nil
    end

    def self.save(scope, id, content)
      return self.save_couchdb(scope, id, content) if self.couch

      File.open(dir(scope, id) + id, 'w') do |f|
        f.puts encode(content)
      end

      true
    end

    def self.save_couchdb(scope, id, content)
      id = [scope, id].join('/')
      begin
        doc = self.couch.get(id)
      rescue RestClient::ResourceNotFound
        doc = {'_id' => id}
      end
      doc.merge({'content' => content})
      self.couch.save_doc(doc)
    end

    def self.dir(scope, id)
      path = FileUtils.mkdir_p "#{DIR}/#{scope}/#{id[0...2]}/#{id[2...4]}/"

      # In Ruby 1.9, mkdir_p always returns Array,
      # while in 1.8 it returns String when it has only one item to return.
      if path.is_a? Array
        path[0]
      else
        path
      end
    end

  private
    def self.encode(object)
      Zlib::Deflate.deflate Yajl::Encoder.encode(object)
    end

    def self.decode(object)
      Yajl::Parser.parse(Zlib::Inflate.inflate(object)) rescue nil
    end
  end
end
