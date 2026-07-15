const guardians = [];

for (let i = 1; i <= 20; i++) {
    const student = `STU${String(i).padStart(3, '0')}`;

    if (i <= 5) {
        guardians.push(
            {
                student,
                relation_type: 'father',
                name: `Father-${i}`,
                contact: `Father Contact ${i}`,
                mobile: `90000100${String(i).padStart(2, '0')}`,
                occupation: 'Service',
                email: `father_${i}@example.com`,
                annualincome: '500000',
                guardianrelation: 'father',
            },
            {
                student,
                relation_type: 'mother',
                name: `Mother-${i}`,
                contact: `Mother Contact ${i}`,
                mobile: `90000200${String(i).padStart(2, '0')}`,
                occupation: 'Homemaker',
                email: `mother_${i}@example.com`,
                annualincome: '500000',
                guardianrelation: 'mother',
            }
        );
    } else {
        guardians.push({
            student,
            relation_type: 'guardian',
            name: `Guardian-${i}`,
            contact: `Guardian Contact ${i}`,
            mobile: `90000300${String(i).padStart(2, '0')}`,
            occupation: 'Service',
            email: `guardian_${i}@example.com`,
            annualincome: '400000',
            guardianrelation: 'guardian',
        });
    }
}

export default guardians;