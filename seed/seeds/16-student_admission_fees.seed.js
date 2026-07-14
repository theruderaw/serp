import fees from '../data/student_admission_fees.seed.js';

export async function seedStudentAdmissionFees(client, ctx) {
    ctx.studentAdmissionFees = [];

    const sql = `
        INSERT INTO student_admission_fees (
            studentid,
            admissionfee,
            tuitionfee,
            scholarship,
            discount,
            paymentmode,
            transactionid
        )
        VALUES (
            $1,$2,$3,$4,$5,$6,$7
        )
        RETURNING *;
    `;

    for (const fee of fees) {
        const { rows } = await client.query(sql, [
            ctx.student[fee.student].id,

            fee.admissionfee,
            fee.tuitionfee,

            fee.scholarship,
            fee.discount,

            fee.paymentmode,

            fee.transactionid,
        ]);

        ctx.studentAdmissionFees.push(rows[0]);
    }

    console.log(
        `✓ Seeded ${ctx.studentAdmissionFees.length} student admission fees`
    );
}