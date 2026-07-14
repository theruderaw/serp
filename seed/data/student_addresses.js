const addresses = Array.from({ length: 10 }, (_, i) => ({
    student: `STU${String(i + 1).padStart(3, '0')}`,

    address: `House ${i + 1}, Main Road`,
    permanentaddress: `Permanent Address ${i + 1}`,

    state: "West Bengal",
    district: "Kolkata",
    city: "Kolkata",

    pincode: `7000${String(i + 1).padStart(2, '0')}`,
}));

export default addresses;