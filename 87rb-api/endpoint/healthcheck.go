package endpoint

import (
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/quilt/facility/httpserver"
)


type GetHealthCheckLogic struct {
	QuiltApplicationLogger logger.Logger
}

func (ghcl *GetHealthCheckLogic) Validate(errors *httpserver.ServiceErrors, request *httpserver.JsonRequest) {
}

func (ghcl *GetHealthCheckLogic) Process(request *httpserver.JsonRequest) *httpserver.JsonResponse {

	response := httpserver.NewJsonResponse()

	status := new(HealthCheckStatus)
	status.DatabaseConnectivity = true

	response.Body = status


	return response
}

type HealthCheckStatus struct {
	DatabaseConnectivity bool
}

