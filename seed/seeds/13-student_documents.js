import documents from '../data/student_documents.js';

export async function seedStudentDocuments(client, ctx) {
    ctx.studentDocuments = [];

    const sql = `
        INSERT INTO student_documents (
            studentid,
            doc_type,
            doc_url
        )
        VALUES (
            $1,$2,$3
        )
        RETURNING *;
    `;

    for (const document of documents) {
        const { rows } = await client.query(sql, [
            ctx.student[document.student].id,

            document.doc_type,

            document.doc_url,
        ]);

        ctx.studentDocuments.push(rows[0]);
    }

    console.log(`✓ Seeded ${ctx.studentDocuments.length} student documents`);
}