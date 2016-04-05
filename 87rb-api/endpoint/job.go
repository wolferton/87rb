package endpoint

import (
	"net/http"
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/87rb/87rb-api/dao"
	"encoding/json"
)

type PostJobHandler struct {
	logger logger.Logger
	JobDao *dao.JobDao
}

func (pjh *PostJobHandler) SetApplicationLogger(logger logger.Logger) {
	pjh.logger = logger
}

/*func (pjh *PostJobHandler) SetJobDao(jobDao dao.JobDao) {
	pjh.jobDao = jobDao
}*/

func (pjh *PostJobHandler) ServeHTTP(w http.ResponseWriter, req *http.Request) {

	w.Write([]byte("{\"id\":0}"))

	var parsed map[string]interface{}

	json.NewDecoder(req.Body).Decode(&parsed)

	pjh.logger.LogDebug(parsed["name"].(string))

	pjh.JobDao.CreateJob()
}