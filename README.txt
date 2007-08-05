GRuby
    by FaziBear
    http://gruby.rubyforge.org 

== DESCRIPTION:
  
Gadu-Gadu protocol implementation for Ruby language

== FEATURES/PROBLEMS:
  
* loggin
* set status
* set status messages
* send messages
* recive messages

== SYNOPSIS:

  require File.dirname(__FILE__) + '/../lib/GRuby'

  gg_uin  = ''
  gg_pass = ''

  gg = GG::new_session :uin => gg_uin, :password => gg_pass
  gg.on_recive_message do |m|
    gg.set_status :status => GG::STATUS_AVAIL_DESCR, :description => m.message
    gg.send_message :uin => m.sender, :message => "Status '#{m.message}' was set"
  end
  gg.set_status :status => GG::STATUS_AVAIL_DESCR, :description => "Send me new status :)"

  gets

== REQUIREMENTS:

* ruby
* gadu-gadu account

== INSTALL:

* sudo gem install gruby

== LICENSE:

(The MIT License)

Copyright (c) 2007 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
