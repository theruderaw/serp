import students from '../data/students.js';

export async function seedStudents(client, ctx) {
    ctx.students = [];
    ctx.student = {};

    const sql = `
        INSERT INTO students (
            user_id,
            name,
            rollno,
            enrollmentno,
            classid,
            schoolid,
            stream,
            admissiondate,
            dob,
            age,
            gender,
            middlename,
            lastname,
            category,
            nationality,
            sessionyear,
            section,
            medium,
            bloodgroup,
            weight,
            height,
            avatar,
            metadata
        )
        VALUES (
            $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,
            $11,$12,$13,$14,$15,$16,$17,$18,
            $19,$20,$21,$22,$23
        )
        RETURNING *;
    `;

    for (const student of students) {
        const { rows } = await client.query(sql, [
            ctx.user[student.user].id,

            student.name,
            student.rollno,
            student.enrollmentno,

            student.class
                ? ctx.class[student.class].id
                : null,

            ctx.school[student.school].id,

            student.stream,

            student.admissiondate,
            student.dob,
            student.age,

            student.gender,

            student.middlename,
            student.lastname,

            student.category,

            student.nationality,

            student.sessionyear,

            student.section,

            student.medium,

            student.bloodgroup,

            student.weight,
            student.height,

            student.avatar,

            JSON.stringify(student.metadata),
        ]);

        const created = rows[0];

        ctx.students.push(created);
        ctx.student[created.enrollmentno] = created;
    }

    console.log(`✓ Seeded ${ctx.students.length} students`);
}