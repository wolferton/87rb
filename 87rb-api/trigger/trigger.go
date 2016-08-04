package trigger

import (
	"encoding/json"
	"net/http"
	"bytes"
	"errors"
	"fmt"
	"github.com/graniticio/granitic/logging"
)

const (
	NewJob = "NEW_JOB"
)

type TriggerNotifier interface {
	Notify(ref string, event string)
}

type HttpTriggerNotifier struct {
	TriggerUri string
	HealthCheckUri string
	Log logging.Logger
}


func (htn *HttpTriggerNotifier) Notify(ref string, event string) {

	bodyStruct := PostJobLifecycle{ref, event}

	data, _ := json.Marshal(bodyStruct)

	resp, err := http.Post(htn.TriggerUri, "application/json", bytes.NewReader(data))

	if err != nil {
		htn.Log.LogErrorf("Unable to send job lifecycle event %s/%s to %s %s", ref, event, htn.TriggerUri, err)
	} else {
		resp.Body.Close()
	}
}

func (htm *HttpTriggerNotifier) BlockAccess() (bool, error) {

	available, err := htm.triggerAvailable()

	if available {
		return false, nil
	} else {

		message := fmt.Sprintf("Unable to contact trigger: %s", err)

		return true, errors.New(message)
	}


}

func (htm *HttpTriggerNotifier) triggerAvailable() (bool, error){
	resp, err := http.Get(htm.HealthCheckUri)

	if err != nil {
		return false, err
	}


	return err == nil && resp.StatusCode == http.StatusOK, nil

}

type PostJobLifecycle struct {
	Ref string
	Event string
}