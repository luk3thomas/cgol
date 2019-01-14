package main

import (
	"log"
	"runtime"
	"time"

	"gopkg.in/alexcesaro/statsd.v2"
)

var metrics = NewStatsdClient()

func NewStatsdClient() *statsd.Client {
	c, err := statsd.New()
	if err != nil {
		log.Fatalln("Could not start statsd")
	}
	return c
}

func StartInstrumentation() {
	ticker := time.NewTicker(time.Second)
	for {
		<-ticker.C
		metrics.Gauge("sockets-talk.connectedClients", len(clientPool.clients))
		metrics.Gauge("sockets-talk.goRoutines", runtime.NumGoroutine())
	}
}
