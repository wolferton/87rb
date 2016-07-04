package endpoint

import (
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/quilt/ws"
)

type PostJobLifecycleLogic struct {
	QuiltApplicationLogger logger.Logger

}

func (pjll *PostJobLifecycleLogic) Validate(errors *ws.ServiceErrors, request *ws.WsRequest) {

}

func (pjll *PostJobLifecycleLogic) Process(request *ws.WsRequest, response *ws.WsResponse){
	jl := request.RequestBody.(*JobLifecycle)
	l := pjll.QuiltApplicationLogger

	l.LogDebugf("Job lifecycle notification %s/%s", jl.Ref, jl.Event)

}

func (pjl *PostJobLifecycleLogic) UnmarshallTarget() interface{} {
	return new(JobLifecycle)
}

type JobLifecycle struct {
	Ref string
	Event string
}

