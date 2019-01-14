package main

import (
	"log"
	"time"

	"github.com/gorilla/websocket"
)

type Message struct {
	Payload []byte
	Time    time.Time
	Source  string
}

type Client struct {
	name         string
	conn         *websocket.Conn
	pool         *ClientPool
	onRead       chan *Message
	onWrite      chan *Message
	onDisconnect chan *Client
}

func (c *Client) Read() {
	defer c.Cleanup()

	for {
		_, message, err := c.conn.ReadMessage()
		if err != nil {
			log.Println("Websocket client error", err)
			break
		}
		c.onRead <- &Message{
			Source:  c.name,
			Time:    time.Now(),
			Payload: message,
		}
	}
}

func (c *Client) Writes() {
	defer c.Cleanup()

	for {
		message, ok := <-c.onWrite
		if !ok {
			return
		}

		metrics.Increment("sockets-talk.websocket.onWrite")
		err := c.conn.WriteJSON(message)

		if err != nil {
			return
		}
	}
}

func (c *Client) Cleanup() {
	c.pool.onDisconnect <- c
}
