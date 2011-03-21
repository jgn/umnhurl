require 'fileutils'
require 'couchrest'

module Hurl
  class DB
    def self.couch
      return @couch if @couch
      couch_url = ENV['COUCH_URL']    if !!ENV['COUCH_URL']
      couch_url = ENV['CLOUDANT_URL'] if !!ENV['CLOUDANT_URL']
      if couch_url
        @couch = CouchRest.database(couch_url)
      end
    end

    def self.find(scope, id)
      id = [scope, id].join('/')
      self.couch.get(id)['content']
    rescue RestClient::ResourceNotFound
      nil
    end

    def self.save(scope, id, content)
      id = [scope, id].join('/')
      begin
        doc = self.couch.get(id)
      rescue RestClient::ResourceNotFound
        doc = {'_id' => id}
      end
      doc.merge({'content' => content})
      self.couch.save_doc(doc)
      true
    end
  end
end
