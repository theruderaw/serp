const documents = Array.from({ length: 20 }, (_, i) => ({
    student: `STU${String(i + 1).padStart(3, '0')}`,

    doc_type: "birth_certificate",

    doc_url: `/documents/student_${String(i + 1).padStart(3, '0')}/birth_certificate.pdf`,
}));

export default documents;