!#/usr/bin/env ruby

require 'cinch'

my_name = "fakefriendbot"
server_host = "irc.freenode.org"
channel_name = "#fiendboyz.test"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = server_host
    c.channels = [channel_name]
    c.nick = my_name
    c.user = my_name
  end

  on :message, /^!say/ do |m|
    this_channel = Channel(channel_name)

    reply_message = m.message.split[1..-1].join(' ')
    this_channel.msg reply_message
  end
end

bot.start
