package dao

import (
	"github.com/wolferton/quilt/facility/rdbms"
	"github.com/wolferton/87rb/87rb-api/dto"
	"github.com/wolferton/quilt/logging"
)

const apiUserId  = 70
const PeriodicSchedule = "PERIODIC"


type JobDao struct {
	ConnectionString string
	QuiltApplicationLogger logging.Logger
}

func (jd *JobDao) CreateJob(job *dto.PostJob, rc *rdbms.RdbmsClient) error {

	params := make(map[string]interface{}, 2)

	params["ref"] = job.Ref
	params["userId"] = apiUserId
	params["scheduleType"] = PeriodicSchedule
	params["overlap"] = job.Overlap


	id, err := rc.InsertQueryIdParamMapReturnedId("SCHEDULE_INSERT", params)

	if err != nil {
		return err
	}

	params["scheduleId"] = id

	_, err = rc.InsertQueryIdParamMap("JOBS_INSERT", params)


	return err

}


func (jd *JobDao) JobExists(jobRef string, rc *rdbms.RdbmsClient) (bool, error) {

	params := make(map[string]interface{}, 1)
	params["ref"] = jobRef

	rows, err := rc.SelectQueryIdParamMap("JOB_ID_FROM_REF", params)

	if err != nil {
		return true, err
	}

	defer rows.Close()

	return rows.Next(), nil
}