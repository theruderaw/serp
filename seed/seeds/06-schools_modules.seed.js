import schoolModules from '../data/schools_modules.js';

export async function seedSchoolModules(client, ctx) {
    ctx.schoolModules = [];

    const sql = `
        INSERT INTO school_modules (
            school_id,
            module_id,
            is_active
        )
        VALUES ($1, $2, $3)
        RETURNING *;
    `;

    
    for (const item of schoolModules) {
        const { rows } = await client.query(sql, [
            ctx.school.id,
            ctx.module[item.module].id,
            item.is_active,
        ]);

        ctx.schoolModules.push(rows[0]);
    }

    console.log(`✓ Seeded ${ctx.schoolModules.length} school modules`);
}