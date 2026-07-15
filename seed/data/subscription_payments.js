// data/subscription_payment.js

const payments = [];

const schools = [
    {
        school: 'school-1',
        amount: 25000,
    },
    {
        school: 'school-2',
        amount: 10000,
    },
    {
        school: 'school-3',
        amount: 50000,
    },
];

const paymentModes = [
    'Bank Transfer',
    'UPI',
    'NEFT',
];

for (const { school, amount } of schools) {
    for (let i = 0; i < 3; i++) {
        payments.push({
            school,
            amount,
            paymentmode: paymentModes[i],
            receipturl: `/uploads/receipts/${school}-${i + 1}.pdf`,
            status: i === 2 ? 'Pending' : 'Verified',
            validuntil: i === 2 ? null : `202${7 + i}-04-01`,
            remark:
                i === 2
                    ? null
                    : 'Payment verified successfully.',
            school_remark:
                i === 2
                    ? 'Awaiting verification.'
                    : `Subscription payment #${i + 1}.`,
        });
    }
}

export default payments;