package endpoint

import (
	"github.com/wolferton/87rb/87rb-api/dao"
	"github.com/wolferton/87rb/87rb-api/dto"
	"github.com/graniticio/granitic/ws"
	"github.com/wolferton/87rb/87rb-api/trigger"
	"strings"
	"github.com/graniticio/granitic/facility/rdbms"
	"github.com/graniticio/granitic/logging"
)

const (
	jobExists = "JOB001"
	jobCouldNotCheckExists = "JOB002"
	jobCouldNotCreateDb = "JOB003"
	jobInvalidRef = "JOB004"
	maxJobLength = 32
)


type PostJobLogic struct {
	Log logging.Logger
	JobDao                 *dao.JobDao
	TriggerNotifier trigger.TriggerNotifier
	RdbmsClientManager rdbms.RdbmsClientManager
}


func (pjl *PostJobLogic) Validate(errors *ws.ServiceErrors, request *ws.WsRequest) {

	job := request.RequestBody.(*dto.PostJob)
	dao := pjl.JobDao
	rc := pjl.RdbmsClientManager.Client()

	exists, err := dao.JobExists(job.Ref, rc)

	if err != nil {
		pjl.Log.LogErrorf("Problem checking to see if job with reference %s, already exists: %s", job.Ref, err)
		errors.AddPredefinedError(jobCouldNotCheckExists)

	} else if exists {
		errors.AddPredefinedError(jobExists)
	}


	l := len(job.Ref)

	if  l > maxJobLength || len(strings.TrimSpace(job.Ref)) < l {
		errors.AddPredefinedError(jobInvalidRef)
	}

}

func (pjl *PostJobLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	rc := pjl.RdbmsClientManager.Client()
	job := request.RequestBody.(*dto.PostJob)

	rc.StartTransaction()
	defer rc.Rollback()

	err := pjl.JobDao.CreateJob(job, rc)

	if err != nil {
		pjl.Log.LogErrorf("Problem creating new Job %s ", err)
		response.Errors.AddPredefinedError(jobCouldNotCreateDb)

		return
	}

	rc.CommitTransaction()

	go pjl.TriggerNotifier.Notify(job.Ref, trigger.NewJob)

	result := new(PostJobResult)
	result.Id = 0

	response.Body = result

}

func (pjl *PostJobLogic) UnmarshallTarget() interface{} {
	return new(dto.PostJob)
}


type PostJobResult struct {
	Id int
}