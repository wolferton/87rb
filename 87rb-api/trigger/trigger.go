package trigger

import (
	"encoding/json"
	"net/http"
	"github.com/wolferton/quilt/facility/logger"
	"bytes"
)

const (
	NewJob = "NEW_JOB"
)

type TriggerNotifier interface {
	Notify(ref string, event string)
}

type HttpTriggerNotifier struct {
	TriggerUri string
	QuiltApplicationLogger logger.Logger
}


func (htn *HttpTriggerNotifier) Notify(ref string, event string) {

	bodyStruct := PostJobLifecycle{ref, event}

	data, _ := json.Marshal(bodyStruct)

	resp, err := http.Post(htn.TriggerUri, "application/json", bytes.NewReader(data))

	if err != nil {
		htn.QuiltApplicationLogger.LogErrorf("Unable to send job lifecycle event %s/%s to %s %s", ref, event, htn.TriggerUri, err)
	}

	defer resp.Body.Close()
}

type PostJobLifecycle struct {
	Ref string
	Event string
}