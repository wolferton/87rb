package dao

import (
	"github.com/wolferton/quilt/facility/logger"
	"database/sql"
	_ "github.com/lib/pq"
)

type JobDao struct {
	ConnectionString string
	QuiltApplicationLogger logger.Logger
}

func (jd *JobDao) CreateJob() {
	db, err := sql.Open("postgres", jd.ConnectionString)

	if err != nil {
		jd.QuiltApplicationLogger.LogError(err.Error())
	}

	err = db.Ping()

	if err != nil {
		jd.QuiltApplicationLogger.LogError(err.Error())
	}
}

func (jd *JobDao) SetApplicationLogger(logger logger.Logger) {
	jd.QuiltApplicationLogger = logger
}