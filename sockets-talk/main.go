package main

import (
	"flag"
	"log"
	"net/http"
)

var addr = flag.String("addr", ":8080", "http service address")

var clientPool = NewClientPool()

func main() {
	flag.Parse()
	http.HandleFunc("/", routeIndex)
	http.HandleFunc("/ws", routeWs)

	log.Println("Starting server on http://localhost" + *addr)

	go clientPool.Start()
	go StartInstrumentation()

	err := http.ListenAndServe(*addr, nil)

	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}

}
