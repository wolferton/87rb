package endpoint

import (
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/quilt/ws"
)

type HealthCheckLogic struct {
	QuiltApplicationLogger logger.Logger
}

func (hcl *HealthCheckLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	status := new(HealthCheckStatus)
	status.DatabaseConnectivity = true

	response.Body = status
}

type HealthCheckStatus struct {
	DatabaseConnectivity bool
}