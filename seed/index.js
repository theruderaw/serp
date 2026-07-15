import dotenv from 'dotenv';
import pool from './helpers/db.js';

import { seedSchools } from './seeds/01-schools.seed.js';
import { seedRoles } from './seeds/02-roles.seed.js';
import { seedModules } from './seeds/03-modules.seed.js';
import { seedUsers } from './seeds/04-users.seed.js';
import { seedClasses } from './seeds/05-classes.seed.js';
import { seedSchoolModules } from './seeds/06-schools_modules.seed.js';
import { seedEmployees } from './seeds/07-employees.seed.js';
import { seedStudents } from './seeds/08-students.seed.js';
import { seedGuardians } from './seeds/09-guardians.seed.js';
import { seedStudentAddresses } from './seeds/10-student_addresses.seed.js';
import { seedStudentContacts } from './seeds/11-students_contacts.seed.js';
import { seedStudentAcademicBackground } from './seeds/12-student_academic_background.seed.js';
import { seedStudentDocuments } from './seeds/13-student_documents.js';
import { seedStudentTransport } from './seeds/14-student_transports.js';
import { seedStudentHostel } from './seeds/15-student_hostels.seed.js';
import { seedStudentAdmissionFees } from './seeds/16-student_admission_fees.seed.js';
import { seedEmployeeFinance } from './seeds/17-employee_finances.seed.js';
import { seedSchoolSettings } from './seeds/18-school_settings.seed.js';
import { seedSubscriptionPayments } from './seeds/19-subscription_payments.seed.js';

dotenv.config();

async function seed() {
    const client = await pool.connect();
    const ctx = {};

    try {
        await client.query('BEGIN');

        await seedSchools(client, ctx);
        await seedRoles(client, ctx);
        await seedModules(client, ctx);
        await seedUsers(client,ctx);
        await seedClasses(client,ctx);
        await seedSchoolModules(client,ctx)
        await seedEmployees(client,ctx)
        await seedStudents(client,ctx)
        await seedGuardians(client,ctx)
        await seedStudentAddresses(client,ctx)
        await seedStudentContacts(client,ctx)
        await seedStudentAcademicBackground(client, ctx);
        await seedStudentDocuments(client, ctx);
        await seedStudentTransport(client,ctx)
        await seedStudentHostel(client,ctx)
        await seedStudentAdmissionFees(client,ctx);
        await seedEmployeeFinance(client,ctx)
        await seedSchoolSettings(client,ctx)
        await seedSubscriptionPayments(client,ctx)

        await client.query('COMMIT');

        console.log('✅ Database seeded');
    } catch (err) {
        await client.query('ROLLBACK');
        console.error(err);
        process.exitCode = 1;
    } finally {
        client.release();
        await pool.end();
    }
}

seed();