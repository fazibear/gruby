#!/usr/bin/ruby

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
