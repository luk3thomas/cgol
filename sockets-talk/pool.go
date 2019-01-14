package main

import (
	"log"
	"time"

	"github.com/gorilla/websocket"
)

type ClientPool struct {
	clients      map[*Client]struct{}
	onRead       chan *Message
	onClose      chan *Client
	onConnect    chan *Client
	onDisconnect chan *Client
}

func NewClientPool() *ClientPool {
	return &ClientPool{
		clients:      make(map[*Client]struct{}),
		onRead:       make(chan *Message, 1),
		onClose:      make(chan *Client),
		onConnect:    make(chan *Client),
		onDisconnect: make(chan *Client),
	}
}

func (cp *ClientPool) Add(name string, conn *websocket.Conn) {
	client := &Client{
		pool:         cp,
		name:         name,
		conn:         conn,
		onRead:       cp.onRead,
		onWrite:      make(chan *Message),
		onDisconnect: cp.onDisconnect,
	}

	go client.Read()
	go client.Writes()

	cp.onConnect <- client
}

func (cp *ClientPool) Start() {
	for {
		select {
		case client := <-cp.onConnect:
			log.Println("Client connected")
			cp.clients[client] = struct{}{}
			cp.onRead <- &Message{
				Time:    time.Now(),
				Source:  "server",
				Payload: []byte(client.name + " has joined"),
			}

		case client := <-cp.onDisconnect:
			log.Println("Client disconnected")
			cp.onRead <- &Message{
				Source:  "server",
				Time:    time.Now(),
				Payload: []byte(client.name + " disconnected"),
			}
			client.conn.Close()
			delete(cp.clients, client)

		case message := <-cp.onRead:
			metrics.Increment("sockets-talk.websocket.onRead")
			for c := range cp.clients {
				c.onWrite <- message
			}
		}
	}
}
