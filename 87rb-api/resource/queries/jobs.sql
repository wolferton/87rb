ID:JOBS_INSERT

INSERT INTO jobs.job (
    ref,
    schedule_id,
    created_on,
    created_by,
    updated_on,
    updated_by
) VALUES (
    '${ref}',
    ${scheduleId},
    NOW(),
    ${userId},
    NOW(),
    ${userId}
)

ID:JOB_ID_FROM_REF

SELECT
    id
FROM
    jobs.job
WHERE
    ref = '${ref}'

ID:SCHEDULE_INSERT

INSERT INTO jobs.schedule (
    type,
    created_on,
    created_by,
    updated_on,
    updated_by
) VALUES (
    '${scheduleType}',
    NOW(),
    ${userId},
    NOW(),
    ${userId}
) RETURNING id
