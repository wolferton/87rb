package dao

import (
	"database/sql"
	_ "github.com/lib/pq"
	"github.com/graniticio/granitic/logging"
)

type PostgreSQLCoreDatabaseProvider struct {
	ConnectionString string
	Log logging.Logger
}

func (pdcp *PostgreSQLCoreDatabaseProvider) Database() (*sql.DB, error) {

	db, err := sql.Open("postgres", pdcp.ConnectionString)
	al := pdcp.Log

	if err != nil {
		al.LogErrorf(err.Error())
	}

	return db, err
}