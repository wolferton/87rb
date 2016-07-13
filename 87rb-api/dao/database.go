package dao

import (
	"database/sql"
	_ "github.com/lib/pq"
	"github.com/wolferton/quilt/facility/logger"
)

type PostgreSQLCoreDatabaseProvider struct {
	ConnectionString string
	QuiltApplicationLogger logger.Logger
}

func (pdcp *PostgreSQLCoreDatabaseProvider) Database() (*sql.DB, error) {

	db, err := sql.Open("postgres", pdcp.ConnectionString)
	al := pdcp.QuiltApplicationLogger

	if err != nil {
		al.LogErrorf(err.Error())
	}

	return db, err
}