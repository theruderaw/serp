import addresses from '../data/student_addresses.js';

export async function seedStudentAddresses(client, ctx) {
    ctx.studentAddresses = [];

    const sql = `
        INSERT INTO student_addresses (
            studentid,
            address,
            permanentaddress,
            state,
            district,
            city,
            pincode
        )
        VALUES (
            $1,$2,$3,$4,$5,$6,$7
        )
        RETURNING *;
    `;
    console.log(ctx.student)

    for (const address of addresses) {
        const { rows } = await client.query(sql, [
            ctx.student[address.student].id,

            address.address,
            address.permanentaddress,

            address.state,
            address.district,
            address.city,

            address.pincode,
        ]);

        ctx.studentAddresses.push(rows[0]);
    }

    console.log(`✓ Seeded ${ctx.studentAddresses.length} student addresses`);
}