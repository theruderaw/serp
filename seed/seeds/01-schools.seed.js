import schools from '../data/school.js';

export async function seedSchools(client, ctx) {
    ctx.schools = [];
    ctx.school = {};

    const sql = `
        INSERT INTO schools (
            name,
            slug,
            logo,
            contact_email,
            status,
            plan,
            features,
            theme,
            login_background,
            joined_date,
            academic_year,
            working_days,
            address,
            phone,
            established,
            website
        )
        VALUES (
            $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16
        )
        RETURNING *;
    `;

    for (const school of schools) {
        const { rows } = await client.query(sql, [
            school.name,
            school.slug,
            school.logo,
            school.contact_email,
            school.status,
            school.plan,
            JSON.stringify(school.features),
            school.theme,
            school.login_background,
            school.joined_date,
            school.academic_year,
            JSON.stringify(school.working_days),
            school.address,
            school.phone,
            school.established,
            school.website,
        ]);

        const created = rows[0];

        ctx.schools.push(created);
        ctx.school[created.slug] = created;
    }

    console.log(`✓ Seeded ${ctx.schools.length} schools`);
}