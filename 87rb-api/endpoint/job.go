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
	job := request.RequestBody.(*PostJob)
	dao := pjl.JobDao

	exists, err := dao.JobExists(job.Ref)

	if err != nil {
		pjl.QuiltApplicationLogger.LogErrorf("Problem checking to see if job with reference %s, already exists: %s", job.Ref, err)
		errors.AddError(httpserver.Unexpected, "DB", "Unable to check whether job already exists")

	} else if exists {
		errors.AddError(httpserver.Logic, "JOB001", "Job already exists with that reference")
	}


}

func (pjl *PostJobLogic) Process(request *httpserver.JsonRequest) *httpserver.JsonResponse {


	job := request.RequestBody.(*PostJob)

	pjl.QuiltApplicationLogger.LogInfof("%b %d", job.Schedule.AllowOverlap, job.Schedule.FixedInterval)

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
	Schedule *PostSchedule
}

type PostSchedule struct {
	FixedInterval int
	AllowOverlap bool
}

type PostJobResult struct {
	Id int
}