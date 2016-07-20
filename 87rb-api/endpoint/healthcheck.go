package endpoint

import (
	"github.com/wolferton/quilt/ws"
	"github.com/wolferton/quilt/logging"
)


type GetHealthCheckLogic struct {
	QuiltApplicationLogger logging.Logger
}

func (ghcl *GetHealthCheckLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	status := new(HealthCheckStatus)
	status.DatabaseConnectivity = true

	response.Body = status
}

type HealthCheckStatus struct {
	DatabaseConnectivity bool
}

