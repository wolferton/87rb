package endpoint

import (
	"net/http"
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/quilt/facility/httpserver"
)

type GetHealthCheckHandler struct {
	QuiltApplicationLogger logger.Logger
}

func (ghch *GetHealthCheckHandler) SetApplicationLogger(logger logger.Logger) {
	ghch.QuiltApplicationLogger = logger
}

func (ghch *GetHealthCheckHandler) ServeHTTP(w http.ResponseWriter, req *http.Request) {

	ghch.QuiltApplicationLogger.LogInfo("Healthcheck")

	w.Write([]byte("{\"status\":\"OK\"}"))
}

type GetHealthCheckLogic struct {
	QuiltApplicationLogger logger.Logger
}

func (ghcl *GetHealthCheckLogic) Validate(errors *httpserver.ServiceErrors, request *httpserver.JsonRequest) {
	ghcl.QuiltApplicationLogger.LogInfo("Healthcheck Validate")
}

func (ghcl *GetHealthCheckLogic) Process(request *httpserver.JsonRequest) *httpserver.JsonResponse {

	ghcl.QuiltApplicationLogger.LogInfo("Healthcheck Process")

	response := httpserver.NewJsonResponse()

	return response
}

