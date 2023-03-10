CREATE OR REPLACE VIEW COURSE_SECTIONS_LIST AS
(
    SELECT cs.COURSE_CODE, cs.SECTION_ID, c.COURSE_NAME, t.TERM_NAME AS TERM, u.FULL_NAME AS INSTRUCTOR, COUNT(se.STUDENT_ID) AS TOTAL_ENROLLED, cs.CAPACITY
    FROM COURSE_SECTIONS cs
    JOIN COURSES c ON c.COURSE_CODE = cs.COURSE_CODE
    JOIN USERS u ON u.USER_ID = cs.INSTRUCTOR_ID
    JOIN TERMS t ON t.TERM_ID = cs.TERM_ID
    LEFT JOIN STUDENT_ENROLLMENTS se ON se.COURSE_CODE = cs.COURSE_CODE AND se.SECTION_ID = cs.SECTION_ID
    GROUP BY cs.COURSE_CODE, cs.SECTION_ID, c.COURSE_NAME, t.TERM_NAME, u.FULL_NAME, cs.CAPACITY
    HAVING COUNT(se.STUDENT_ID) < cs.CAPACITY
)
ORDER BY cs.COURSE_CODE ASC, cs.SECTION_ID ASC
WITH READ ONLY;

CREATE OR REPLACE VIEW NUMBER_IN_DEPARTMENT AS
(
    SELECT d.DEPARTMENT_NAME, COUNT(u.USER_ID) AS NUMBER_OF_PEOPLE
    FROM DEPARTMENTS d
    JOIN USERS u ON u.DEPARTMENT_ID = d.DEPARTMENT_ID
    GROUP BY d.DEPARTMENT_NAME, u.USER_ID
)
ORDER BY d.DEPARTMENT_NAME ASC, u.USER_ID ASC
WITH READ ONLY;

CREATE OR REPLACE VIEW PROGRAM_OFFERINGS AS
    (
        SELECT p.PROGRAM_ID, p.PROGRAM_NAME, d.DEPARTMENT_NAME
        FROM PROGRAMS p
        JOIN DEPARTMENTS d ON p.DEPARTMENT_ID = d.DEPARTMENT_ID
    )
ORDER BY p.PROGRAM_NAME ASC
WITH READ ONLY;