package endpoint

import (
	"github.com/wolferton/quilt/ws"
	"github.com/wolferton/quilt/logging"
)

type HealthCheckLogic struct {
	QuiltApplicationLogger logging.Logger
}

func (hcl *HealthCheckLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	status := new(HealthCheckStatus)
	status.DatabaseConnectivity = true

	response.Body = status
}

type HealthCheckStatus struct {
	DatabaseConnectivity bool
}
