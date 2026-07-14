import transports from '../data/student_transports.js';

export async function seedStudentTransport(client, ctx) {
    ctx.studentTransport = [];

    const sql = `
        INSERT INTO student_transport (
            studentid,
            busrequired,
            route,
            pickuppoint
        )
        VALUES (
            $1,$2,$3,$4
        )
        RETURNING *;
    `;

    for (const transport of transports) {
        const { rows } = await client.query(sql, [
            ctx.student[transport.student].id,

            transport.busrequired,

            transport.route,

            transport.pickuppoint,
        ]);

        ctx.studentTransport.push(rows[0]);
    }

    console.log(`✓ Seeded ${ctx.studentTransport.length} student transport records`);
}