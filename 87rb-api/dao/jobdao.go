package dao

import (
	"github.com/wolferton/quilt/facility/rdbms"
	"github.com/wolferton/quilt/facility/logger"
)

type JobDao struct {
	ConnectionString string
	QuiltApplicationLogger logger.Logger
	Accessor *rdbms.DatabaseAccessor
}

func (jd *JobDao) CreateJob(jobRef string) {

	params := make(map[string]interface{}, 2)

	params["ref"] = jobRef
	params["userId"] = 70

	_, err := jd.Accessor.InsertQueryIdParamMap("JOBS_INSERT", params)

	if(err != nil) {
		jd.QuiltApplicationLogger.LogError(err.Error())
	}

}
