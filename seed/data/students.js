const classes = [
    '10:A',
    '9:B',
    '8:A',
];

const students = Array.from({ length: 20 }, (_, i) => ({
    school: 'school-1',

    user: `student_${i + 1}@example.com`,

    name: `Student-${i + 1}`,

    rollno: String(i + 1),

    enrollmentno: `STU${String(i + 1).padStart(3, '0')}`,

    class: classes[i % 3],

    stream: 'None',

    admissiondate: '2024-06-01',

    dob: `2010-01-${String((i % 28) + 1).padStart(2, '0')}`,

    age: 14,

    gender: i % 2 === 0 ? 'Male' : 'Female',

    middlename: null,
    lastname: null,

    category: 'General',

    nationality: 'Indian',

    sessionyear: '2024-2025',

    section: ['A', 'B', 'A'][i % 3],

    medium: 'English',

    bloodgroup: 'O+',

    weight: 45,
    height: 150,

    avatar: null,

    metadata: {}
}));

export default students;