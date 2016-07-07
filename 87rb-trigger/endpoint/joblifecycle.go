package endpoint

import (
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/quilt/ws"
	"github.com/wolferton/87rb/87rb-trigger/lifecycle"
)

type PostJobLifecycleLogic struct {
	QuiltApplicationLogger logger.Logger
	EventListener *lifecycle.LifecycleEventListener

}

func (pjll *PostJobLifecycleLogic) Validate(errors *ws.ServiceErrors, request *ws.WsRequest) {

}

func (pjll *PostJobLifecycleLogic) Process(request *ws.WsRequest, response *ws.WsResponse){
	jl := request.RequestBody.(*JobLifecycle)
	l := pjll.QuiltApplicationLogger

	l.LogDebugf("Job lifecycle notification %s/%s", jl.Ref, jl.Event)

	n := new(lifecycle.EventNotification)
	n.Ref = jl.Ref
	n.Event = lifecycle.Created
	n.Resource = lifecycle.Job

	pjll.EventListener.Notify(n)
	l.LogDebugf("Notified")



}

func (pjl *PostJobLifecycleLogic) UnmarshallTarget() interface{} {
	return new(JobLifecycle)
}

type JobLifecycle struct {
	Ref string
	Event string
}

