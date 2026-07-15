import employees from '../data/employees.js';

export async function seedEmployees(client, ctx) {
    ctx.employees = [];
    ctx.employee = {};

    const sql = `
        INSERT INTO employees (
            user_id,
            school_id,
            registration_no,
            name,
            email,
            phone,
            dob,
            gender,
            address,
            qualification,
            experience,
            specialization,
            department,
            job_title,
            custom_job_title,
            employee_type,
            joining_date,
            father_name,
            mother_name,
            spouse_name,
            emergency_contact,
            emergency_relation,
            blood_group,
            height,
            weight,
            marital_status,
            documents,
            metadata
        )
        VALUES (
            $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,
            $11,$12,$13,$14,$15,$16,$17,$18,$19,
            $20,$21,$22,$23,$24,$25,$26,$27,$28
        )
        RETURNING *;
    `;

    console.log(ctx.school)

    for (const employee of employees) {
        const { rows } = await client.query(sql, [
            ctx.user[employee.user].id,
            ctx.school.id,

            employee.registration_no,

            employee.name,
            employee.email,
            employee.phone,

            employee.dob,
            employee.gender,

            employee.address,

            employee.qualification,
            employee.experience,

            JSON.stringify(employee.specialization),

            employee.department,

            employee.job_title,
            employee.custom_job_title,

            employee.employee_type,

            employee.joining_date,

            employee.father_name,
            employee.mother_name,
            employee.spouse_name,

            employee.emergency_contact,
            employee.emergency_relation,

            employee.blood_group,

            employee.height,
            employee.weight,

            employee.marital_status,

            JSON.stringify(employee.documents),
            JSON.stringify(employee.metadata),
        ]);

        const created = rows[0];

        ctx.employees.push(created);
        ctx.employee[created.registration_no] = created;
        ctx.employee[created.email] = created;
    }

    console.log(`✓ Seeded ${ctx.employees.length} employees`);
}