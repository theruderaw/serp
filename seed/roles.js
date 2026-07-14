export default [
    {
        name: 'student',
        permissions: [],
        is_system: true,
    },
    {
        name: 'employee',
        permissions: [
            'manage_students',
            'manage_exams',
            'attendance_own_class',
            'idcard_settings',
        ],
        is_system: true,
    },
    {
        name: 'school_admin',
        permissions: [],
        is_system: true,
    },
    {
        name: 'super_admin',
        permissions: [],
        is_system: true,
    },
];