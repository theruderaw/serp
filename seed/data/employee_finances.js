const finance = Array.from({ length: 4 }, (_, i) => ({
    employee: `teacher_${String(i + 1)}@example.com`,

    salary: 30000 + (i * 2000),

    bank_account_number: `1234567890${i}`,

    ifsc_code: `SBIN000${100 + i}`,

    pan_number: `ABCDE${1000 + i}F`,

    aadhaar_number: `12345678901${i}`,
}));

export default finance;