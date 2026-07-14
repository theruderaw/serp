const transports = Array.from({ length: 10 }, (_, i) => ({
    student: `STU${String(i + 1).padStart(3, '0')}`,

    busrequired: i % 2 === 0 ? "yes" : "no",

    route: i % 2 === 0 ? `Route-${(i % 3) + 1}` : null,

    pickuppoint: i % 2 === 0 ? `Pickup-Point-${i + 1}` : null,
}));

export default transports;