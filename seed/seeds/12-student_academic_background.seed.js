import academicBackground from '../data/student_academic_background.js';

export async function seedStudentAcademicBackground(client, ctx) {
    ctx.studentAcademicBackground = [];

    const sql = `
        INSERT INTO student_academic_background (
            studentid,
            previousschool,
            previousboard,
            previousclass,
            previouspercentage
        )
        VALUES (
            $1,$2,$3,$4,$5
        )
        RETURNING *;
    `;

    for (const academic of academicBackground) {
        const { rows } = await client.query(sql, [
            ctx.student[academic.student].id,

            academic.previousschool,
            academic.previousboard,
            academic.previousclass,
            academic.previouspercentage,
        ]);

        ctx.studentAcademicBackground.push(rows[0]);
    }

    console.log(
        `✓ Seeded ${ctx.studentAcademicBackground.length} student academic backgrounds`
    );
}