package endpoint

import (
	"net/http"
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/87rb/87rb-api/dao"
	"encoding/json"
)

type PostJobHandler struct {
	QuiltApplicationLogger logger.Logger
	JobDao                 *dao.JobDao
}

func (pjh *PostJobHandler) SetApplicationLogger(logger logger.Logger) {
	pjh.QuiltApplicationLogger = logger
}

/*func (pjh *PostJobHandler) SetJobDao(jobDao dao.JobDao) {
	pjh.jobDao = jobDao
}*/

func (pjh *PostJobHandler) ServeHTTP(w http.ResponseWriter, req *http.Request) {

	var parsed map[string]interface{}

	json.NewDecoder(req.Body).Decode(&parsed)

	jobRef := parsed["ref"].(string)

	pjh.QuiltApplicationLogger.LogInfo(jobRef)


	pjh.JobDao.CreateJob(jobRef)

	w.Write([]byte("{\"id\":0}"))

}