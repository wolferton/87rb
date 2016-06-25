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

