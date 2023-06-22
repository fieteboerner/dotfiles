package main

import (
	"log"

	"github.com/the-jonsey/pulseaudio"
)

func main() {
	client, err := pulseaudio.NewClient()
	if err != nil {
		return
	}

	sinks, err := client.Sinks()

	if err != nil {
		log.Panicln("unable to fetch sinks")
	}

	defaultSink, err := client.GetDefaultSink()
	if err != nil {
		log.Println("[warn] unable to fetch default sink")
		defaultSink = sinks[0]
	}

	newOutput := &pulseaudio.Sink{}
	for i, sink := range sinks {
		if sink.Index != defaultSink.Index {
			continue
		}

		if nextIndex := i + 1; nextIndex < len(sinks) {
			newOutput = &sinks[nextIndex]
		} else {
			newOutput = &sinks[0]
		}

		break
	}

	if newOutput == nil {
		log.Panicln("no new output to set")
	}

	err = client.SetDefaultSink(newOutput.Name)
	if err != nil {
		log.Panicln("unable to set default sink")
	}
}
