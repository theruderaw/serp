import finance from '../data/employee_finances.js';

export async function seedEmployeeFinance(client, ctx) {
    ctx.employeeFinance = [];

    const sql = `
        INSERT INTO employee_finance (
            employee_id,
            salary,
            bank_account_number,
            ifsc_code,
            pan_number,
            aadhaar_number
        )
        VALUES (
            $1,$2,$3,$4,$5,$6
        )
        RETURNING *;
    `;

    for (const item of finance) {
        const { rows } = await client.query(sql, [
            ctx.employee[item.employee].id,

            item.salary,

            item.bank_account_number,

            item.ifsc_code,

            item.pan_number,

            item.aadhaar_number,
        ]);

        ctx.employeeFinance.push(rows[0]);
    }

    console.log(
        `✓ Seeded ${ctx.employeeFinance.length} employee finance records`
    );
}