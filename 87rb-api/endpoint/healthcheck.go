package endpoint

import (
	"net/http"
	"github.com/wolferton/quilt/facility/logger"
)

type GetHealthCheckHandler struct {
	logger logger.Logger
}

func (ghch *GetHealthCheckHandler) SetApplicationLogger(logger logger.Logger) {
	ghch.logger = logger
}

func (ghch *GetHealthCheckHandler) ServeHTTP(w http.ResponseWriter, req *http.Request) {

	w.Write([]byte("{\"status\":\"OK\"}"))
}