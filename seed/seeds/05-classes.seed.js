import classes from '../data/classes.js';

export async function seedClasses(client, ctx) {
    ctx.classes = [];
    ctx.class = {};

    const sql = `
        INSERT INTO classes (
            schoolid,
            name,
            section,
            grade,
            teacherid,
            studentcount,
            capacity,
            stream
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING *;
    `;
    console.log(ctx.user)

    for (const cls of classes) {
        const { rows } = await client.query(sql, [
            ctx.school.id,

            cls.name,
            cls.section,
            cls.grade,

            cls.teacher
                ? ctx.user[cls.teacher].id
                : null,

            cls.studentcount,
            cls.capacity,
            cls.stream,
        ]);

        const created = rows[0];

        ctx.classes.push(created);
        ctx.class[`${cls.grade}:${cls.section}`] = created;
    }

    console.log(`✓ Seeded ${ctx.classes.length} classes`);
}