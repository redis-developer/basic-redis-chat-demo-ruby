# Basic Redis Chat App Demo

A basic chat application built with ActionCable and Redis.

## How it works?

![How it works](public/redis-chat.png)

### How the data is stored:

Redis is used mainly as a cache to keep the user/messages data and for sending messages between connected servers.

- The chat data is stored in various keys and various data types.
  - User data is stored with the next values:
    - `username`: unique user name;
    - `password`: hashed password
  - Room data is stored with the next values:
    - `name`: unique room name;
  - RoomMessage is the connection table to User and Room tables. And this data is stored with the next values:
    - `room_id`: unique room id;
    - `user_id`: unique user id;
    - `message`: text body of message;

## How to run it locally?

#### Run

```sh
mv config/application.example.yml config/application.yml
mv config/database.example.yml config/database.yml
rails db:setup
rails s

Put link `http://localhost:3000` in your browser
```
