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

func (jd *JobDao) CreateJob() {

	err := jd.Accessor.InsertQueryIdParamObject("", nil)

	if(err != nil) {
		jd.QuiltApplicationLogger.LogError(err.Error())
	}

}
