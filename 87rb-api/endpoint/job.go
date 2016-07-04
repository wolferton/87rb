package endpoint

import (
	"github.com/wolferton/quilt/facility/logger"
	"github.com/wolferton/87rb/87rb-api/dao"
	"github.com/wolferton/87rb/87rb-api/dto"
	"github.com/wolferton/quilt/ws"
	"github.com/wolferton/87rb/87rb-api/trigger"
)


type PostJobLogic struct {
	QuiltApplicationLogger logger.Logger
	JobDao                 *dao.JobDao
	TriggerNotifier trigger.TriggerNotifier
}


func (pjl *PostJobLogic) Validate(errors *ws.ServiceErrors, request *ws.WsRequest) {
	job := request.RequestBody.(*dto.PostJob)
	dao := pjl.JobDao

	exists, err := dao.JobExists(job.Ref)

	if err != nil {
		pjl.QuiltApplicationLogger.LogErrorf("Problem checking to see if job with reference %s, already exists: %s", job.Ref, err)
		errors.AddError(ws.Unexpected, "DB", "Unable to check whether job already exists")

	} else if exists {
		errors.AddError(ws.Logic, "JOB001", "Job already exists with that reference")
	}


}

func (pjl *PostJobLogic) Process(request *ws.WsRequest, response *ws.WsResponse){

	job := request.RequestBody.(*dto.PostJob)

	err := pjl.JobDao.CreateJob(job)

	if err != nil {
		pjl.QuiltApplicationLogger.LogErrorf("Problem creating new Job %s ", err)
		response.Errors.AddError(ws.Unexpected, "JOB002", "Unable to store new job in database")
	}

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