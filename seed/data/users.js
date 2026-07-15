const school = 'school-1';

const employees = Array.from({ length: 4 }, (_, i) => ({
    role: 'employee',
    school,
    name: `Teacher-${i + 1}`,
    email: `teacher_${i + 1}@example.com`,
    password: `teacher${i + 1}`,
    avatar: null,
    is_active: true,
}));

const students = Array.from({ length: 20 }, (_, i) => ({
    role: 'student',
    school,
    name: `Student-${i + 1}`,
    email: `student_${i + 1}@example.com`,
    password: `student${i + 1}`,
    avatar: null,
    is_active: true,
}));

const schoolAdmins = Array.from({ length: 2 }, (_, i) => ({
    role: 'school_admin',
    school,
    name: `School-Admin-${i + 1}`,
    email: `school_admin_${i + 1}@example.com`,
    password: 'school123',
    avatar: null,
    is_active: true,
}));

export default [
    {
        role: 'super_admin',
        school: null,
        name: 'Super-Admin',
        email: 'super_admin@example.com',
        password: 'admin123',
        avatar: null,
        is_active: true,
    },

    ...schoolAdmins,
    ...employees,
    ...students,
];