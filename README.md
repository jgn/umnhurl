UmnHurl
=======

This is a conflation of <https://github.com/benatkin/hurl> (for Heroku and CouchDB) and <https://github.com/twilio/hurl> (for Github auth, and other fixes)

Hurl was created for the Rails Rumble 2009 in 48 hours: See <https://github.com/defunkt/hurl>
Now Hurl is an open source project for your enjoyment.

Installation
------------

Hurl requires Ruby 1.8.6+


Run On Heroku & CouchDB
-----------------------

First get a CouchDB database and get the url, including auth. I got my
DB from [Cloudant](https://cloudant.com/).

    heroku create
    heroku rename my-clever-name
    heroku config:add 'COUCH_URL=https://bat:password@bat.cloudant.com/benhurl/'

Now you can go to [http://my-clever-name.heroku.com/](http://my-clever-name.heroku.com/)

To enable github login, register a github app with the callback `http://my-clever-name.heroku.com/login/callback/` and add your configuration:

    heroku config:add 'HURL_CLIENT_ID=your_client_id'
    heroku config:add 'HURL_SECRET=your_secret'

Issues
------

Find a bug? Want a feature? Submit an [issue
here](http://github.com/defunkt/hurl/issues). Patches welcome!


Screenshot
----------

[![Hurl](http://img.skitch.com/20091020-xtiqtj4eajuxs43iu5h3be7upj.png)](http://hurl.it)


Authors
-------

* [Leah Culver][2]
* [Chris Wanstrath][3]


[1]: http://r09.railsrumble.com/
[2]: http://github.com/leah
[3]: http://github.com/defunkt
