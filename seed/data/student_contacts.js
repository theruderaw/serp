const contacts = Array.from({ length: 10 }, (_, i) => ({
    student: `STU${String(i + 1).padStart(3, '0')}`,

    phone: `90001000${i + 1}`,
    mobile: `90002000${i + 1}`,

    email: `student_${String(i + 1).padStart(3, '0')}@example.com`,

    contactnumber: `90003000${i + 1}`,

    emergencycontact: `90004000${i + 1}`,
}));

export default contacts;