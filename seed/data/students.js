const classes = [
    'school-1:10:A',
    'school-2:9:B',
    'school-3:8:A',
];

const students = Array.from({ length: 10 }, (_, i) => ({
    school: `school-${(i % 3) + 1}`,

    user: `student_${String(i + 1).padStart(3, '0')}@example.com`,

    name: `Student-${i + 1}`,

    rollno: String(i + 1),

    enrollmentno: `STU${String(i + 1).padStart(3, '0')}`,

    // Student-10 has no class assigned
    class: i === 9 ? null : classes[i % 3],

    stream: 'None',

    admissiondate: '2024-06-01',

    dob: `2010-01-${String((i % 9) + 1).padStart(2, '0')}`,

    age: 14,

    gender: i % 2 === 0 ? 'Male' : 'Female',

    middlename: null,
    lastname: null,

    category: 'General',

    nationality: 'Indian',

    sessionyear: '2024-2025',

    section: i === 9 ? null : ['A', 'B', 'A'][i % 3],

    medium: 'English',

    bloodgroup: 'O+',

    weight: 45,
    height: 150,

    avatar: null,

    metadata: {}
}));

export default students;