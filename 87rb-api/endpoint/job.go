package endpoint

import (
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/87rb/87rb-api/dao"
	"github.com/wolferton/quilt/facility/httpserver"
)

type PostJobLogic struct {
	QuiltApplicationLogger logger.Logger
	JobDao                 *dao.JobDao
}


func (pjl *PostJobLogic) Validate(errors *httpserver.ServiceErrors, request *httpserver.JsonRequest) {
}

func (pjl *PostJobLogic) Process(request *httpserver.JsonRequest) *httpserver.JsonResponse {


	job := request.RequestBody.(*PostJob)

	pjl.JobDao.CreateJob(job.Ref)


	response := httpserver.NewJsonResponse()

	result := new(PostJobResult)
	result.Id = 0

	response.Body = result


	return response
}

func (pjl *PostJobLogic) UnmarshallTarget() interface{} {
	return new(PostJob)
}

type PostJob struct {
	Ref string
}

type PostJobResult struct {
	Id int
}