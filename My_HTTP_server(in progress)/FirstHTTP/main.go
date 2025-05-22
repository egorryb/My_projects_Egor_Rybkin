package main

import (
	"FirstHTTP/HTTP"
	"FirstHTTP/strg"
	"flag"
	"log"
)

func main() {
	addr := flag.String("addr", ":8080", "address for http server")
	s := strg.NewRamStorage()
	log.Printf("Starting server on %s", *addr)
	if err := HTTP.CreateAndRunServer(s, *addr); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
	// var photo jsonwork.Photo
	// jsonwork.LoadFromJSON("C:\\Users\\Egor\\Desktop\\ИТМО УЧЕБА\\GO\\FirstHTTP\\jsonwork\\data.json", &photo)
	// photo.LookatPhoto()
}
