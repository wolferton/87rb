package dao

import (
	"github.com/wolferton/quilt/facility/rdbms"
	"github.com/wolferton/quilt/facility/logger"
)

const apiUserId  = 70
const PeriodicSchedule = "PERIODIC"


type JobDao struct {
	ConnectionString string
	QuiltApplicationLogger logger.Logger
	Accessor *rdbms.DatabaseAccessor
}

func (jd *JobDao) CreateJob(jobRef string) error {

	params := make(map[string]interface{}, 2)

	params["ref"] = jobRef
	params["userId"] = 70
	params["scheduleType"] = PeriodicSchedule


	id, err := jd.Accessor.InsertQueryIdParamMapReturnedId("SCHEDULE_INSERT", params)

	if err != nil {
		return err
	}

	params["scheduleId"] = id

	_, err = jd.Accessor.InsertQueryIdParamMap("JOBS_INSERT", params)

	return err

}


func (jd *JobDao) JobExists(jobRef string) (bool, error) {

	params := make(map[string]interface{}, 1)
	params["ref"] = jobRef

	rows, err := jd.Accessor.SelectQueryIdParamMap("JOB_ID_FROM_REF", params)

	if err != nil {
		return true, err
	}

	defer rows.Close()

	return rows.Next(), nil
}