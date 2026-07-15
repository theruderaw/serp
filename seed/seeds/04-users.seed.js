import users from '../data/users.js';
import { hashPassword } from '../helpers/password.js';

export async function seedUsers(client, ctx) {
    ctx.users = [];
    ctx.user = {};

    const sql = `
        INSERT INTO users (
            school_id,
            role_id,
            name,
            email,
            password,
            avatar,
            is_active
        )
        VALUES ($1,$2,$3,$4,$5,$6,$7)
        RETURNING *;
    `;

    for (const user of users) {
        const { rows } = await client.query(sql, [
            user.school
                ? ctx.school.id
                : null,

            ctx.role[user.role].id,

            user.name,
            user.email,
            await hashPassword(user.password),
            user.avatar,
            user.is_active,
        ]);

        const created = rows[0];

        ctx.users.push(created);
        ctx.user[user.email] = created;
    }

    console.log(`✓ Seeded ${ctx.users.length} users`);
}