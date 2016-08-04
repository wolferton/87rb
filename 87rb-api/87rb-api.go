package main

import (
	"github.com/graniticio/granitic/initiation"
	"github.com/wolferton/87rb/87rb-api/bindings"
)

func main() {

	quiltInitiator := new(initiation.Initiator)
	quiltInitiator.Start(bindings.Components())
}
