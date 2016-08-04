package endpoint

import (
	"github.com/graniticio/granitic/ws"
	"github.com/graniticio/granitic/logging"
)


type GetHealthCheckLogic struct {
	Log logging.Logger
}

func (ghcl *GetHealthCheckLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	status := new(HealthCheckStatus)
	status.DatabaseConnectivity = true

	response.Body = status
}

type HealthCheckStatus struct {
	DatabaseConnectivity bool
}

