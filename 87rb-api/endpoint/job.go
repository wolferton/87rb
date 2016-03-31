package endpoint

import (
	"net/http"
	"github.com/wolferton/quilt/facility/logger"
)

type PostJobHandler struct {
	logger logger.Logger
}

func (pjh *PostJobHandler) SetApplicationLogger(logger logger.Logger) {
	pjh.logger = logger
}


func (pjh *PostJobHandler) ServeHTTP(w http.ResponseWriter, req *http.Request) {

	w.Write([]byte("{\"id\":0}"))
}