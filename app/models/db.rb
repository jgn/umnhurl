require 'fileutils'
require 'couchrest'

module Hurl
  class DB
    def self.couch
      @couch_url ||= ENV['COUCH_URL'] || ENV['CLOUDANT_URL']
      @couch ||= CouchRest.database(@couch_url) if @couch_url
    end

    def self.find(scope, id)
      id = [scope, id].join('.')
      self.couch.get(id)['content']
    rescue RestClient::ResourceNotFound
      nil
    end

    def self.save(scope, id, content)
      id = [scope, id].join('.')
      begin
        doc = self.couch.get(id)
      rescue RestClient::ResourceNotFound
        doc = {'_id' => id}
      end
      doc.merge!({'content' => content})
      self.couch.save_doc(doc)
      true
    end
  end
end
