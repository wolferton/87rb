package endpoint

import (
	"net/http"
	"github.com/wolferton/quilt/facility/logger"
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