import contacts from '../data/student_contacts.js';

export async function seedStudentContacts(client, ctx) {
    ctx.studentContacts = [];

    const sql = `
        INSERT INTO student_contacts (
            studentid,
            phone,
            mobile,
            email,
            contactnumber,
            emergencycontact
        )
        VALUES (
            $1,$2,$3,$4,$5,$6
        )
        RETURNING *;
    `;

    for (const contact of contacts) {
        const { rows } = await client.query(sql, [
            ctx.student[contact.student].id,

            contact.phone,
            contact.mobile,

            contact.email,

            contact.contactnumber,

            contact.emergencycontact,
        ]);

        ctx.studentContacts.push(rows[0]);
    }

    console.log(`✓ Seeded ${ctx.studentContacts.length} student contacts`);
}