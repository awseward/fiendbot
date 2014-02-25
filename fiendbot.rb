require 'cinch'
require 'cinch/plugins/identify'

# vars and whatnot

mode = ARGV[0]
if mode == "production"
  nemesis_name = "friendbot"
  channel_name = "#friendboyz"
else
  nemesis_name = "fakefriendbot"
  channel_name = "#fiendboyz.test"
end
  
my_name = "fiendbot"
server_hostname = "irc.freenode.org"

general_responses = [
                     "Leave me alone!",
                     "Go away!",
                     "Get out of my face!",
                     "Get off my lawn!",
                     "Ughh.",
                     "Jeez! What do you want?",
                     "You talk too much.",
                     "...seriously?",
                     "You don't know me!",
                     "I don't have time for this!",
                     "Hey... can you not?",
                     "Get lost!",
                     "Just don't.",
                     "Are you done?",
                     "You've gotta be kidding me!",
                     "Excuse me?!",
                     "What!",
                     "Ummmm... no.",
                     "...",
                     "WRONG!",
                     "Knock it off!",
                     "Get out of here!"
                    ]

fiendbot_questions = [
                      "Did somebody say",
                      "Did I hear",
                      "Did someone just say",
                      "Correct me if I'm wrong, but did I just hear",
                      "Could someone really have said"
                     ]

friendbot_responses = [
                           "Somebody did say",
                           "Someone said",
                           "I think someone said",
                           "I definitely heard",
                           "Somebody mentioned an"
                          ]

def random_choice(phrase_array)
  random_index = rand(phrase_array.length)
  phrase_array[random_index]
end

can_speak = true

# bot creation

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

  on :message, /^#{my_name}/i do |m|
    m.reply random_choice general_responses
  end

  on :message, /infinite loop/i do |m|
    if can_speak
      nemesis = User(nemesis_name)
      sleep 1
      m.reply "Hey #{nemesis.nick}! #{random_choice fiendbot_questions} \"infinite loop\"?!"
      sleep 1
      nemesis.send "!say Yes, #{my_name}! #{random_choice friendbot_responses} \"infinite loop\"!!"
    else
      can_speak = true
    end
  end

  on :message, /knock it off/i do |m|
    can_speak = false
    m.reply "Sorry, #{m.user.nick}. Jeez!"
  end
end

bot.start
