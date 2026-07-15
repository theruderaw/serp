const employees = Array.from({ length: 4 }, (_, i) => ({
    school: 'school-1',
    user: `teacher_${i + 1}@example.com`,

    registration_no: `EMP${String(i + 1).padStart(3, '0')}`,

    name: `Teacher-${i + 1}`,
    email: `teacher_${i + 1}@example.com`,
    phone: `900000000${i + 1}`,

    dob: `1990-01-${String(i + 1).padStart(2, '0')}`,
    gender: i % 2 === 0 ? 'Male' : 'Female',

    address: 'School Address',

    qualification: 'B.Ed',
    experience: `${i + 1} years`,

    specialization: {
        subjects: ['General']
    },

    department: 'Teaching',

    job_title: 'Teacher',
    custom_job_title: null,

    employee_type: 'Permanent',

    joining_date: '2024-06-01',

    father_name: null,
    mother_name: null,
    spouse_name: null,

    emergency_contact: null,
    emergency_relation: null,

    blood_group: 'O+',

    height: null,
    weight: null,

    marital_status: 'Single',

    documents: {},
    metadata: {}
}));

export default employees;