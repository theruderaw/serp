import modules from '../data/modules.js';

export async function seedModules(client, ctx) {
    ctx.modules = [];
    ctx.module = {};

    const sql = `
        INSERT INTO modules (
            name,
            description,
            features,
            is_active,
            icon
        )
        VALUES ($1, $2, $3, $4, $5)
        RETURNING *;
    `;

    for (const module of modules) {
        const { rows } = await client.query(sql, [
            module.name,
            module.description,
            JSON.stringify(module.features),
            true,
            module.icon,
        ]);

        const created = rows[0];

        ctx.modules.push(created);
        ctx.module[created.name] = created;
    }

    console.log(`✓ Seeded ${ctx.modules.length} modules`);
}