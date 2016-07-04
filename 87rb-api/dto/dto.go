package dto

type PostJob struct {
	Ref string
	Schedule *PostSchedule
	Overlap string
}

type PostSchedule struct {
	FixedInterval int
}
