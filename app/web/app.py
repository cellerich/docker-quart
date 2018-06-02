#!/usr/bin/env python
# encoding:utf-8

from quart import Quart, websocket

app = Quart(__name__)

@app.route('/')
async def hello():
    return 'Hello World for Docker-quart with Python3.6 !'

@app.websocket('/ws')
async def ws():
    while True:
        await websocket.send('Hello World for Docker-quart with Python3.6 !')


