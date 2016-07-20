package lifecycle

import (
	"github.com/wolferton/quilt/logging"
)

type ResourceType int

const (
	Job  = iota
)

type LifecyleEvent int

const (
	Created = iota
	Modified
	Destroyed
)

type EventNotification struct {
	Resource ResourceType
	Event LifecyleEvent
	Ref string
	Id int
}

func (en *EventNotification) String() string {
	return en.Ref
}


type LifecycleEventListener struct {
	QuiltApplicationLogger logging.Logger
	events chan *EventNotification
}

func (lel *LifecycleEventListener) StartComponent() error {

	lel.events = make(chan *EventNotification)

	go lel.Listen()

	return nil
}

func (lel *LifecycleEventListener) Notify(event *EventNotification) {
	lel.events <- event
}

func (lel *LifecycleEventListener) Listen() {

	l := lel.QuiltApplicationLogger
	l.LogDebugf("Listening for lifecycle events")

	for {
		event := <- lel.events
		l.LogTracef("Received event %s", event)
	}

}


