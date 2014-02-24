require 'cinch'
require 'cinch/plugins/identify'

my_name = "fiendbot"
nemesis_name = "fakefriendbot"
server_hostname = "irc.freenode.org"
channel_name = "#fiendboyz.test"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = server_hostname
    c.channels = [channel_name]
    c.nick = my_name
    c.user = my_name
    c.plugins.plugins = [Cinch::Plugins::Identify]
    c.plugins.options[Cinch::Plugins::Identify] = {
      :username => "fiendbot",
      :password => "regularsp0ol",
      :type     => :nickserv
    }
  end

  on :message, /^#{my_name}/ do |m|
    m.reply "leave me alone"
  end

  on :message, /infinite loop/ do |m|
    nemesis = User(nemesis_name)
    sleep 1
    m.reply "Hey #{nemesis.nick}! Did somebody say \"infinite loop\"?!"
    sleep 1
    nemesis.send "!say Yes, #{my_name}! Somebody did say \"infinite loop\"!!"
  end
end

bot.start
