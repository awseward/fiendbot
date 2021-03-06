#!/usr/bin/env ruby

require 'cinch'
require 'cinch/plugins/identify'
require 'yaml'

responses = YAML.load_file("responses.yml")

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
server_hostname = "irc.freenode.net"

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

  # on :connect do
  #   Channel(channel_name).send(random_choice responses[:fiendbot_greetings])
  # end

  on :message, /#{my_name}/i do |m|
    m.reply random_choice responses[:general_responses]
  end

  on :message, "clear" do |m|
    m.reply "This isn't your terminal, ya dingus!"
  end
  
  on :message, /^ls/ do |m|
    m.reply "This isn't your terminal, ya dingus!"
  end
  
  on :message, /^git/ do |m|
    m.reply "This isn't your terminal, ya dingus!"
  end

  on :message, /^quit/ do |m|
    m.reply "This isn't your terminal, ya dingus!"
  end

  on :message, /^exit/ do |m|
    m.reply "This isn't your terminal, ya dingus!"
  end

  on :message, /infinite loop/i do |m|
    if can_speak
      nemesis = User(nemesis_name)
      sleep 1
      m.reply "Hey #{nemesis.nick}! #{random_choice responses[:fiendbot_questions]} \"infinite loop\"?!"
      sleep 1
      nemesis.send "!say Yes, #{my_name}! #{random_choice responses[:friendbot_responses]} \"infinite loop\"!!"
    else
      can_speak = true
    end
  end

  on :message, /knock it off/i do |m|
    can_speak = false
    m.reply "Sorry, #{m.user.nick}. Jeez!"
  end

  on :message, /^word/i do |m|
    m.reply "Well eeeeeverybody's heard!"
    m.reply "About the word!"
    m.reply "B-b-b-bird, bird, bird! B-b-bird is the word!"
  end
  
  on :message, /^what what/i do |m|
    m.reply "In the butt!"
  end
end

bot.start
