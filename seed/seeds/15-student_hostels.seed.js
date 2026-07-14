import hostels from '../data/student_hostels.js';

export async function seedStudentHostel(client, ctx) {
    ctx.studentHostel = [];

    const sql = `
        INSERT INTO student_hostel (
            studentid,
            name,
            hostelrequired,
            hostelroom
        )
        VALUES (
            $1,$2,$3,$4
        )
        RETURNING *;
    `;

    for (const hostel of hostels) {
        const { rows } = await client.query(sql, [
            ctx.student[hostel.student].id,

            hostel.name,

            hostel.hostelrequired,

            hostel.hostelroom,
        ]);

        ctx.studentHostel.push(rows[0]);
    }

    console.log(`✓ Seeded ${ctx.studentHostel.length} student hostel records`);
}