package main

import (
	"github.com/graniticio/granitic"
	"github.com/wolferton/87rb/87rb-trigger/bindings"
)

func main() {

	granitic.StartGranitic(bindings.Components())
}
