const hostels = Array.from({ length: 20 }, (_, i) => ({
    student: `STU${String(i + 1).padStart(3, '0')}`,

    name: i % 3 === 0 ? `Hostel-${(i % 3) + 1}` : null,

    hostelrequired: i % 3 === 0 ? "yes" : "no",

    hostelroom: i % 3 === 0 ? `Room-${101 + i}` : null,
}));

export default hostels;