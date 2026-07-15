import roles from '../data/roles.js';

export async function seedRoles(client, ctx) {
    ctx.roles = [];
    ctx.role = {};

    const sql = `
        INSERT INTO roles (
            school_id,
            name,
            permissions,
            is_system
        )
        VALUES ($1, $2, $3, $4)
        RETURNING *;
    `;

    for (const role of roles) {
        const { rows } = await client.query(sql, [
            null,
            role.name,
            JSON.stringify(role.permissions),
            role.is_system,
        ]);

        const created = rows[0];

        ctx.roles.push(created);
        ctx.role[created.name] = created;
    }

    console.log(`✓ Seeded ${ctx.roles.length} roles`);
}