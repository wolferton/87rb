ID:JOBS_INSERT

INSERT INTO jobs.job (
    ref,
    created_on,
    created_by,
    updated_by,
    updated_on
) VALUES (
    '${ref}',
    NOW(),
    ${userId},
    NOW(),
    ${userId}
)

