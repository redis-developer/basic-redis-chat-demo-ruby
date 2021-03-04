# Basic Redis Chat App Demo

A basic chat application built with Ruby on Rails with ActionCable and Redis.
Chat refers to the process of communicating, interacting and/or exchanging messages. It involves two or more individuals that communicate through a chat-enabled service or software.

## How it works?

![How it works](public/redis-chat.png)

### How the data is stored:

Redis is used mainly as a database to keep the user/messages data and for sending messages between connected servers.

The real-time functionality is handled by **Server Sent Events** for server->client messaging. Additionally each server instance subscribes to the `MESSAGES` channel

- The chat data is stored in various keys and various data types.
  - User data is stored in a hash set where each user entry contains the next values:
    - `username`: unique user name;
    - `password`: hashed password
  - Additionally a set of rooms is associated with user
  - **Rooms** are sorted sets which contains messages where score is the timestamp for each message
    - Each room has a name associated with it
  - **Online** set is global for all users is used for keeping track on which user is online.

**User** hash set is accessed by key `user:{userId}`. The data for it stored with `HSET key field data`. User id is calculated by incrementing the `total_users` key (`INCR total_users`)

**Username** is stored as a separate key (`username:{username}`) which returns the userId for quicker access and stored with `SET username:{username} {userId}`.

**Rooms** which user has may too are stored at `id:{userIds}` as a set of room ids.

**Messages** are stored at `room:{roomId}` key in a sorted set (as mentioned above). 

### How the data is accessed:

- Get User `HGETALL {username}`
- Online users: `HGETALL {online_users}`. This will return ids of users which are online
- Get rooms: `HGETALL room_name:{id}`
- Get list of messages `HGETALL room_message:{room_id}`

## How to run it locally?

### Prerequisites

- Ruby - v2.6.2
- Rails - v5.2.4.5
- PostgreSQL - v10.16
- NPM - v7.6.0

#### Run

```sh
# copy files and set proper data inside
cp config/application.example.yml config/application.yml
- REDIS_URL: Redis server URI

cp config/database.example.yml config/database.yml
rails db:setup
```

#### Run the app

```sh
rails s
```

#### Put this link in your browser(localhost example)

```sh
http://localhost:3000
```
