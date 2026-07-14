const schools = [
    'school-1',
    'school-2',
    'school-3',
];

const employees = Array.from({ length: 10 }, (_, i) => ({
    role: 'employee',
    school: schools[i % 3],
    name: `Teacher-${i + 1}`,
    email: `teacher_${String(i + 1).padStart(3, '0')}@example.com`,
    password: 'employee123',
    avatar: null,
    is_active: true,
}));

const students = Array.from({ length: 10 }, (_, i) => ({
    role: 'student',
    school: schools[i % 3],
    name: `Student-${i + 1}`,
    email: `student_${String(i + 1).padStart(3, '0')}@example.com`,
    password: 'student123',
    avatar: null,
    is_active: true,
}));

const schoolAdmins = schools.map((school, i) => ({
    role: 'school_admin',
    school,
    name: `School-Admin-${i + 1}`,
    email: `school_admin_${i + 1}@example.com`,
    password: 'school_admin123',
    avatar: null,
    is_active: true,
}));

export default [
    {
        role: 'super_admin',
        school: null,
        name: 'Super-Admin',
        email: 'super_admin@example.com',
        password: 'super_admin123',
        avatar: null,
        is_active: true,
    },

    ...schoolAdmins,
    ...employees,
    ...students,
];