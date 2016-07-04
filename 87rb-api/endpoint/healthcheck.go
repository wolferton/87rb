package endpoint

import (
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/quilt/ws"
)


type GetHealthCheckLogic struct {
	QuiltApplicationLogger logger.Logger
}

func (ghcl *GetHealthCheckLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	status := new(HealthCheckStatus)
	status.DatabaseConnectivity = true

	response.Body = status
}

type HealthCheckStatus struct {
	DatabaseConnectivity bool
}

