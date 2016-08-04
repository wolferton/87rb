package endpoint

import (
	"github.com/graniticio/granitic/ws"
	"github.com/graniticio/granitic/logging"
)

type HealthCheckLogic struct {
	Log logging.Logger
}

func (hcl *HealthCheckLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	status := new(HealthCheckStatus)
	status.DatabaseConnectivity = true

	response.Body = status
}

type HealthCheckStatus struct {
	DatabaseConnectivity bool
}
