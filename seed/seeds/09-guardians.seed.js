import guardians from '../data/guardians.js';

export async function seedGuardians(client, ctx) {
    ctx.guardians = [];
    ctx.guardian = {};

    const sql = `
        INSERT INTO guardians (
            studentid,
            relation_type,
            name,
            contact,
            mobile,
            occupation,
            email,
            annualincome,
            guardianrelation
        )
        VALUES (
            $1,$2,$3,$4,$5,$6,$7,$8,$9
        )
        RETURNING *;
    `;

    for (const guardian of guardians) {
        const { rows } = await client.query(sql, [
            ctx.student[guardian.student].id,

            guardian.relation_type,

            guardian.name,
            guardian.contact,
            guardian.mobile,

            guardian.occupation,

            guardian.email,

            guardian.annualincome,

            guardian.guardianrelation,
        ]);

        const created = rows[0];

        ctx.guardians.push(created);
        ctx.guardian[created.id] = created;
    }

    console.log(`✓ Seeded ${ctx.guardians.length} guardians`);
}