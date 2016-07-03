ID:JOBS_INSERT

INSERT INTO jobs.job (
    ref,
    created_on,
    created_by,
    updated_on,
    updated_by
) VALUES (
    '${ref}',
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
