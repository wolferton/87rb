package main

import (
	"github.com/wolferton/87rb/87rb-api/bindings"
	"github.com/graniticio/granitic"
)

func main() {
	granitic.StartGranitic(bindings.Components())
}
