package dao

import (
	"github.com/wolferton/quilt/facility/logger"
	//"database/sql"
	//_ "github.com/lib/pq"
)

type JobDao struct {
	logger logger.Logger
	connectionString string
}

func (jd *JobDao) CreateJob() {

}