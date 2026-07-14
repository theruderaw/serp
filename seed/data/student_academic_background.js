const academicBackground = Array.from({ length: 10 }, (_, i) => ({
    student: `STU${String(i + 1).padStart(3, '0')}`,

    previousschool: `Previous School-${i + 1}`,

    previousboard: "CBSE",

    previousclass: "Class-9",

    previouspercentage: `${70 + i}%`,
}));

export default academicBackground;