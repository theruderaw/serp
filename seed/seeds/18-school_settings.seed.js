import schoolSettings from '../data/school_settings.js';

export async function seedSchoolSettings(client, ctx) {
    ctx.schoolSettings = [];

    const sql = `
        INSERT INTO school_settings (
            school_id,
            setting_key,
            setting_value
        )
        VALUES ($1, $2, $3)
        RETURNING *;
    `;

    for (const setting of schoolSettings) {
        const { rows } = await client.query(sql, [
            ctx.school.id,
            setting.setting_key,
            setting.setting_value,
        ]);

        const created = rows[0];
        ctx.schoolSettings.push(created);
    }

    console.log(`✓ Seeded ${ctx.schoolSettings.length} school settings`);
}