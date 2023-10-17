import requests
from twitchAPI import Twitch
from twitchAPI.oauth import UserAuthenticator
from twitchAPI.types import AuthScope, ChatEvent
from twitchAPI.chat import Chat, EventData, ChatMessage, ChatSub, ChatCommand
import asyncio, csv
import serial
import time

serial_port = serial.Serial('/dev/ttys002', 9600)
# Replace these with your Client ID and OAuth token
APP_ID = 'p80mbph3wdhr6kqs2ic7gib68xd2cf'
APP_SECRET = 'gayq3ewwzrktbifk2wadhedjmu54xw'
USER_SCOPE = [AuthScope.CHAT_READ, AuthScope.CHAT_EDIT]
TARGET_CHANNEL = '16mega'
CSV_FILENAME = "commandstream.csv"

viewers = 0

# this will be called when the event READY is triggered, which will be on bot start
async def on_ready(ready_event: EventData):
    print('Bot is ready for work, joining channels')
    # join our target channel, if you want to join multiple, either call join for each individually
    # or even better pass a list of channels as the argument
    await ready_event.chat.join_room(TARGET_CHANNEL)
    # you can do other bot initialization things in here


# # this will be called whenever a message in a channel was send by either the bot OR another user
async def on_message(msg: ChatMessage):
    print(f' {msg.user.name} said: {msg.text}')
    global viewers
    message = str(viewers)+","+msg.user.name+" said: "+msg.text+"\n"
    serial_port.write(message.encode())


async def on_join(msg: ChatMessage):
    print(f' {msg.user_name} joined your chat!')
    global viewers
    viewers +=1
    message = str(viewers)+","+msg.user_name+" joined your chat!"+"\n"
    serial_port.write(message.encode())
    #add 1 to the user count.

async def on_leave(msg: ChatMessage):
    print(f' {msg.user_name} left your chat!')
    global viewers
    if(viewers>0):
        viewers-=1
    message = str(viewers)+","+msg.user_name+" left your chat!"+"\n"
    serial_port.write(message.encode())
    #subtract 1 to the user count where more than 0.

# # this will be called whenever someone subscribes to a channel
# async def on_sub(sub: ChatSub):
#     print(f'New subscription in {sub.room.name}:\\n'
#           f'  Type: {sub.sub_plan}\\n'
#           f'  Message: {sub.sub_message}')


# this will be called whenever the !reply command is issued
async def test_command(cmd: ChatCommand):
    if len(cmd.parameter) == 0:
        await cmd.reply('you did not tell me what to reply with')
    else:
        await cmd.reply(f'{cmd.user.name}: {cmd.parameter}')


# this is where we set up the bot
async def run():
    # set up twitch api instance and add user authentication with some scopes
    twitch = await Twitch(APP_ID, APP_SECRET)
    auth = UserAuthenticator(twitch, USER_SCOPE)
    token, refresh_token = await auth.authenticate()
    await twitch.set_user_authentication(token, USER_SCOPE, refresh_token)

    # create chat instance
    chat = await Chat(twitch)

    # register the handlers for the events you want

    # listen to when the bot is done starting up and ready to join channels
    chat.register_event(ChatEvent.READY, on_ready)
    # # listen to chat messages
    chat.register_event(ChatEvent.JOIN, on_join)
    chat.register_event(ChatEvent.LEFT, on_leave)
    chat.register_event(ChatEvent.MESSAGE, on_message)
    # # listen to channel subscriptions
    # chat.register_event(ChatEvent.SUB, on_sub)
    # there are more events, you can view them all in this documentation

    # you can directly register commands and their handlers, this will register the !reply command



    # we are done with our setup, lets start this bot up!
    chat.start()

    # lets run till we press enter in the console
    try:
        input('press ENTER to stop\\n')
    finally:
        # now we can close the chat bot and the twitch api client
        chat.stop()
        await twitch.close()


# lets run our setup
asyncio.run(run())