Hurl
====

Hurl was created for the Rails Rumble 2009 in 48 hours.
Now Hurl is an open source project for your enjoyment.

<http://hurl.it/>

This Fork
---------

I forked hurl to work on Heroku & CouchDB.

Installation
------------

Hurl requires Ruby 1.8.6+

First download hurl and cd into the directory:

    git clone git://github.com/defunkt/hurl
    cd hurl

Or download [the zip](http://github.com/defunkt/hurl/zipball/master).

Next make sure you have [RubyGems](https://rubygems.org/pages/download) installed.

Then install [Bundler](http://gembundler.com/):

    gem install bundler

Now install Hurl's dependencies:

    bundle install


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
