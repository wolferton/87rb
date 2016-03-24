package main

import "fmt"
import "time"

func main() {

	for{	
		fmt.Printf("Hello, world (trigger).\n")
		time.Sleep(5000 * time.Millisecond)
	}
}
