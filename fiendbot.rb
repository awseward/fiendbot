require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#fiendboyz.test"]
    c.nick = "fiendbot"
    c.user = "fiendbot"
  end

  on :message, /fiendbot/ do |m|
    m.reply "Hello #{m.user.nick}!"
  end
end

bot.start
