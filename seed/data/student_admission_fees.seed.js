const fees = Array.from({ length: 20 }, (_, i) => ({
    student: `STU${String(i + 1).padStart(3, '0')}`,

    admissionfee: "25000",

    tuitionfee: "50000",

    scholarship: i % 3 === 0 ? "5000" : "0",

    discount: i % 2 === 0 ? "2000" : "0",

    paymentmode: i % 2 === 0 ? "online" : "cash",

    transactionid: i % 2 === 0
        ? `TXN${String(i + 1).padStart(5, '0')}`
        : null,
}));

export default fees;