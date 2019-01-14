package main

import (
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/websocket"
)

func routeIndex(w http.ResponseWriter, r *http.Request) {
	log.Println(r.URL)
	http.ServeFile(w, r, "public/index.html")
}

var wsUpgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
}

var counter = 0

func routeWs(w http.ResponseWriter, r *http.Request) {
	conn, err := wsUpgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("Could not upgrade websocket connection", err)
	}

	counter++

	clientPool.Add("user "+strconv.Itoa(counter), conn)
}
