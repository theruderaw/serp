import subscriptionPayments from '../data/subscription_payments.js';

export async function seedSubscriptionPayments(client, ctx) {
    const sql = `
        INSERT INTO subscription_payments (
            schoolid,
            amount,
            paymentmode,
            receipturl,
            status,
            validuntil,
            remark,
            school_remark
        )
        VALUES (
            $1,$2,$3,$4,$5,$6,$7,$8
        )
        RETURNING *;
    `;

    ctx.subscriptionPayments = [];

    for (const payment of subscriptionPayments) {

        const { rows } = await client.query(sql, [
            ctx.school.id,
            payment.amount,
            payment.paymentmode,
            payment.receipturl,
            payment.status,
            payment.validuntil,
            payment.remark,
            payment.school_remark,
        ]);

        ctx.subscriptionPayments.push(rows[0]);
    }

    console.log(
        `✓ Seeded ${ctx.subscriptionPayments.length} subscription payments`
    );
}