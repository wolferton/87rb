package main


import (
	"github.com/cbroglie/mustache"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
)

func main() {
	flag.Parse()
	templateFile := flag.Arg(0)
	contextFile := flag.Arg(1)
	outputFile := flag.Arg(2)

	contextData, err := ioutil.ReadFile(contextFile)
	check(err)

	var loadedConfig interface{}
	err = json.Unmarshal(contextData, &loadedConfig)
	check(err)

	results, err := mustache.RenderFile(templateFile, loadedConfig)

	err = ioutil.WriteFile(outputFile, []byte(results), 0644)
	check(err)


	fmt.Printf(templateFile)
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}