package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {

		path := html.EscapeString(r.URL.Path)

		fmt.Fprintf(w, "Hello there, %q", path)
		log.Printf("Served path %q", path)

	})

	if err := http.ListenAndServe(":8008", nil); err != nil {
		log.Fatal(err)
	}
}
