--
-- PostgreSQL database dump
--

\restrict BrMBPGPTEXyTHtsKl6GTP0bM0b5YGM8GrQABaLllwNCTjhtPX6WmuM2cH6BFymh

-- Dumped from database version 18.4 (Ubuntu 18.4-0ubuntu0.26.04.1)
-- Dumped by pg_dump version 18.4 (Ubuntu 18.4-0ubuntu0.26.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: rudra
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO rudra;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: rudra
--

COMMENT ON SCHEMA public IS '';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: employees_gender; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.employees_gender AS ENUM (
    'Male',
    'Female',
    'Other'
);


ALTER TYPE public.employees_gender OWNER TO rudra;

--
-- Name: employees_status; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.employees_status AS ENUM (
    'Active',
    'Inactive',
    'On Leave',
    'Terminated'
);


ALTER TYPE public.employees_status OWNER TO rudra;

--
-- Name: guardian_relation_type; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.guardian_relation_type AS ENUM (
    'father',
    'mother',
    'guardian'
);


ALTER TYPE public.guardian_relation_type OWNER TO rudra;

--
-- Name: schools_plan; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.schools_plan AS ENUM (
    'basic',
    'pro',
    'enterprise'
);


ALTER TYPE public.schools_plan OWNER TO rudra;

--
-- Name: schools_status; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.schools_status AS ENUM (
    'active',
    'inactive',
    'trial'
);


ALTER TYPE public.schools_status OWNER TO rudra;

--
-- Name: students_academicstatus; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.students_academicstatus AS ENUM (
    'In-Progress',
    'Completed',
    'Failed'
);


ALTER TYPE public.students_academicstatus OWNER TO rudra;

--
-- Name: students_feestatus; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.students_feestatus AS ENUM (
    'pending',
    'paid',
    'partial'
);


ALTER TYPE public.students_feestatus OWNER TO rudra;

--
-- Name: students_status; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.students_status AS ENUM (
    'active',
    'inactive',
    'archived'
);


ALTER TYPE public.students_status OWNER TO rudra;

--
-- Name: students_stream; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.students_stream AS ENUM (
    'None',
    'Science',
    'Commerce',
    'Arts'
);


ALTER TYPE public.students_stream OWNER TO rudra;

--
-- Name: subscription_payments_status; Type: TYPE; Schema: public; Owner: rudra
--

CREATE TYPE public.subscription_payments_status AS ENUM (
    'Pending',
    'Verified',
    'Rejected'
);


ALTER TYPE public.subscription_payments_status OWNER TO rudra;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: classes; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.classes (
    id text DEFAULT (gen_random_uuid())::text NOT NULL,
    schoolid uuid,
    name text,
    section text,
    grade integer,
    teacherid uuid,
    studentcount integer DEFAULT 0,
    capacity integer DEFAULT 40,
    stream text DEFAULT 'None'::text
);


ALTER TABLE public.classes OWNER TO rudra;

--
-- Name: employee_finance; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.employee_finance (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    employee_id uuid,
    salary numeric(10,2),
    bank_account_number text,
    ifsc_code text,
    pan_number text,
    aadhaar_number text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.employee_finance OWNER TO rudra;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.employees (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    school_id uuid,
    registration_no text,
    name text NOT NULL,
    email text,
    phone text,
    dob date,
    gender public.employees_gender,
    address text,
    qualification text,
    experience text,
    specialization jsonb DEFAULT '{}'::jsonb,
    department text,
    job_title text,
    custom_job_title text,
    employee_type text,
    joining_date date,
    father_name text,
    mother_name text,
    spouse_name text,
    emergency_contact text,
    emergency_relation text,
    blood_group text,
    height text,
    weight text,
    marital_status text,
    documents jsonb DEFAULT '{}'::jsonb,
    metadata jsonb DEFAULT '{}'::jsonb,
    status public.employees_status DEFAULT 'Active'::public.employees_status,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.employees OWNER TO rudra;

--
-- Name: guardians; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.guardians (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    studentid uuid NOT NULL,
    relation_type public.guardian_relation_type NOT NULL,
    name text,
    contact text,
    mobile text,
    occupation text,
    email text,
    annualincome text,
    guardianrelation text
);


ALTER TABLE public.guardians OWNER TO rudra;

--
-- Name: modules; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.modules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    features jsonb DEFAULT '{}'::jsonb NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    icon text
);


ALTER TABLE public.modules OWNER TO rudra;

--
-- Name: reminders; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.reminders (
    id bigint NOT NULL,
    schoolid text NOT NULL,
    message text NOT NULL,
    isread boolean DEFAULT false NOT NULL,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.reminders OWNER TO rudra;

--
-- Name: reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: rudra
--

CREATE SEQUENCE public.reminders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reminders_id_seq OWNER TO rudra;

--
-- Name: reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rudra
--

ALTER SEQUENCE public.reminders_id_seq OWNED BY public.reminders.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id uuid,
    name text NOT NULL,
    permissions jsonb DEFAULT '[]'::jsonb NOT NULL,
    is_system boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.roles OWNER TO rudra;

--
-- Name: school_modules; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.school_modules (
    school_id uuid NOT NULL,
    module_id uuid NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.school_modules OWNER TO rudra;

--
-- Name: school_settings; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.school_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id uuid NOT NULL,
    setting_key text NOT NULL,
    setting_value text,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.school_settings OWNER TO rudra;

--
-- Name: schools; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.schools (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text,
    logo text,
    contact_email text,
    status public.schools_status DEFAULT 'active'::public.schools_status NOT NULL,
    plan public.schools_plan DEFAULT 'basic'::public.schools_plan NOT NULL,
    features jsonb DEFAULT '{}'::jsonb NOT NULL,
    theme text DEFAULT 'light'::text NOT NULL,
    login_background text,
    joined_date date,
    academic_year text,
    working_days jsonb DEFAULT '[]'::jsonb NOT NULL,
    address text,
    phone text,
    established integer,
    website text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    principal uuid,
    expires_at date
);


ALTER TABLE public.schools OWNER TO rudra;

--
-- Name: student_academic_background; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.student_academic_background (
    studentid uuid NOT NULL,
    previousschool text,
    previousboard text,
    previousclass text,
    previouspercentage text
);


ALTER TABLE public.student_academic_background OWNER TO rudra;

--
-- Name: student_addresses; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.student_addresses (
    studentid uuid NOT NULL,
    address text,
    permanentaddress text,
    state text,
    district text,
    city text,
    pincode text
);


ALTER TABLE public.student_addresses OWNER TO rudra;

--
-- Name: student_admission_fees; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.student_admission_fees (
    studentid uuid NOT NULL,
    admissionfee text,
    tuitionfee text,
    scholarship text,
    discount text,
    paymentmode text,
    transactionid text
);


ALTER TABLE public.student_admission_fees OWNER TO rudra;

--
-- Name: student_contacts; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.student_contacts (
    studentid uuid NOT NULL,
    phone text,
    mobile text,
    email text,
    contactnumber text,
    emergencycontact text
);


ALTER TABLE public.student_contacts OWNER TO rudra;

--
-- Name: student_documents; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.student_documents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    studentid uuid NOT NULL,
    doc_type text,
    doc_url text,
    uploaded_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.student_documents OWNER TO rudra;

--
-- Name: student_hostel; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.student_hostel (
    studentid uuid NOT NULL,
    hostelrequired text,
    hostelroom text,
    name text
);


ALTER TABLE public.student_hostel OWNER TO rudra;

--
-- Name: student_transport; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.student_transport (
    studentid uuid NOT NULL,
    busrequired text,
    route text,
    pickuppoint text
);


ALTER TABLE public.student_transport OWNER TO rudra;

--
-- Name: students; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.students (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    name text NOT NULL,
    rollno text,
    enrollmentno text,
    classid text,
    schoolid uuid,
    stream public.students_stream DEFAULT 'None'::public.students_stream,
    admissiondate date,
    dob date,
    age integer,
    gender text,
    middlename text,
    lastname text,
    category text,
    religion text,
    nationality text,
    aadhaarnumber text,
    sessionyear text,
    section text,
    medium text,
    course text,
    semester text,
    bloodgroup text,
    weight numeric(5,2),
    height numeric(5,2),
    avatar text,
    status public.students_status DEFAULT 'active'::public.students_status,
    academicstatus public.students_academicstatus DEFAULT 'In-Progress'::public.students_academicstatus,
    feestatus public.students_feestatus DEFAULT 'pending'::public.students_feestatus,
    attendance numeric(5,2) DEFAULT 0.00,
    archive_remark text,
    metadata jsonb
);


ALTER TABLE public.students OWNER TO rudra;

--
-- Name: subscription_payments; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.subscription_payments (
    id bigint NOT NULL,
    schoolid text,
    amount numeric(10,2) DEFAULT NULL::numeric,
    paymentmode text,
    receipturl text,
    status public.subscription_payments_status DEFAULT 'Pending'::public.subscription_payments_status,
    validuntil date,
    remark text,
    school_remark text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.subscription_payments OWNER TO rudra;

--
-- Name: subscription_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: rudra
--

CREATE SEQUENCE public.subscription_payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_payments_id_seq OWNER TO rudra;

--
-- Name: subscription_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rudra
--

ALTER SEQUENCE public.subscription_payments_id_seq OWNED BY public.subscription_payments.id;


--
-- Name: subscription_settings; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.subscription_settings (
    school_id text NOT NULL,
    billing_mode text DEFAULT 'Cumulative'::text NOT NULL,
    per_student_price numeric(10,2) DEFAULT 0.00,
    yearly_per_student_price numeric(10,2) DEFAULT 0.00,
    monthly_amount numeric(10,2),
    yearly_amount numeric(10,2),
    discount_amount numeric(10,2),
    discount_text text,
    gst_percentage numeric(5,2) DEFAULT 0.00 NOT NULL,
    valid_until date,
    validity_remark text,
    upi_id text,
    bank_name text,
    bank_account_no text,
    bank_ifsc text,
    bank_branch text,
    bank_details text,
    qr_code_url text,
    CONSTRAINT subscription_settings_billing_mode_check CHECK ((billing_mode = ANY (ARRAY['Cumulative'::text, 'Per Student'::text])))
);


ALTER TABLE public.subscription_settings OWNER TO rudra;

--
-- Name: users; Type: TABLE; Schema: public; Owner: rudra
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    school_id uuid,
    role_id uuid,
    name text NOT NULL,
    email text,
    password text,
    avatar text,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO rudra;

--
-- Name: reminders id; Type: DEFAULT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.reminders ALTER COLUMN id SET DEFAULT nextval('public.reminders_id_seq'::regclass);


--
-- Name: subscription_payments id; Type: DEFAULT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.subscription_payments ALTER COLUMN id SET DEFAULT nextval('public.subscription_payments_id_seq'::regclass);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: employee_finance employee_finance_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.employee_finance
    ADD CONSTRAINT employee_finance_employee_id_key UNIQUE (employee_id);


--
-- Name: employee_finance employee_finance_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.employee_finance
    ADD CONSTRAINT employee_finance_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: employees employees_user_id_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_user_id_key UNIQUE (user_id);


--
-- Name: guardians guardians_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.guardians
    ADD CONSTRAINT guardians_pkey PRIMARY KEY (id);


--
-- Name: modules modules_name_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_name_key UNIQUE (name);


--
-- Name: modules modules_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (id);


--
-- Name: reminders reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: roles roles_school_id_name_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_school_id_name_key UNIQUE (school_id, name);


--
-- Name: school_modules school_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.school_modules
    ADD CONSTRAINT school_modules_pkey PRIMARY KEY (school_id, module_id);


--
-- Name: school_settings school_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.school_settings
    ADD CONSTRAINT school_settings_pkey PRIMARY KEY (id);


--
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: schools schools_slug_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_slug_key UNIQUE (slug);


--
-- Name: student_academic_background student_academic_background_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_academic_background
    ADD CONSTRAINT student_academic_background_pkey PRIMARY KEY (studentid);


--
-- Name: student_addresses student_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_addresses
    ADD CONSTRAINT student_addresses_pkey PRIMARY KEY (studentid);


--
-- Name: student_admission_fees student_admission_fees_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_admission_fees
    ADD CONSTRAINT student_admission_fees_pkey PRIMARY KEY (studentid);


--
-- Name: student_contacts student_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_contacts
    ADD CONSTRAINT student_contacts_pkey PRIMARY KEY (studentid);


--
-- Name: student_documents student_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_documents
    ADD CONSTRAINT student_documents_pkey PRIMARY KEY (id);


--
-- Name: student_hostel student_hostel_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_hostel
    ADD CONSTRAINT student_hostel_pkey PRIMARY KEY (studentid);


--
-- Name: student_transport student_transport_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_transport
    ADD CONSTRAINT student_transport_pkey PRIMARY KEY (studentid);


--
-- Name: students students_enrollmentno_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_enrollmentno_key UNIQUE (enrollmentno);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: students students_user_id_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_key UNIQUE (user_id);


--
-- Name: subscription_payments subscription_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.subscription_payments
    ADD CONSTRAINT subscription_payments_pkey PRIMARY KEY (id);


--
-- Name: subscription_settings subscription_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.subscription_settings
    ADD CONSTRAINT subscription_settings_pkey PRIMARY KEY (school_id);


--
-- Name: school_settings unique_school_setting; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.school_settings
    ADD CONSTRAINT unique_school_setting UNIQUE (school_id, setting_key);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_classes_schoolid; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX idx_classes_schoolid ON public.classes USING btree (schoolid);


--
-- Name: idx_guardians_studentid; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX idx_guardians_studentid ON public.guardians USING btree (studentid);


--
-- Name: idx_student_documents_studentid; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX idx_student_documents_studentid ON public.student_documents USING btree (studentid);


--
-- Name: idx_students_classid; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX idx_students_classid ON public.students USING btree (classid);


--
-- Name: idx_students_schoolid; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX idx_students_schoolid ON public.students USING btree (schoolid);


--
-- Name: idx_students_user_id; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX idx_students_user_id ON public.students USING btree (user_id);


--
-- Name: school_modules_module_id_idx; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX school_modules_module_id_idx ON public.school_modules USING btree (module_id);


--
-- Name: users_school_id_idx; Type: INDEX; Schema: public; Owner: rudra
--

CREATE INDEX users_school_id_idx ON public.users USING btree (school_id);


--
-- Name: classes classes_schoolid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_schoolid_fkey FOREIGN KEY (schoolid) REFERENCES public.schools(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: classes classes_teacherid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_teacherid_fkey FOREIGN KEY (teacherid) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: employee_finance employee_finance_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.employee_finance
    ADD CONSTRAINT employee_finance_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- Name: employees employees_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE CASCADE;


--
-- Name: employees employees_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: guardians guardians_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.guardians
    ADD CONSTRAINT guardians_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: roles roles_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE CASCADE;


--
-- Name: school_modules school_modules_module_fk; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.school_modules
    ADD CONSTRAINT school_modules_module_fk FOREIGN KEY (module_id) REFERENCES public.modules(id) ON DELETE CASCADE;


--
-- Name: school_modules school_modules_school_fk; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.school_modules
    ADD CONSTRAINT school_modules_school_fk FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE CASCADE;


--
-- Name: school_settings school_settings_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.school_settings
    ADD CONSTRAINT school_settings_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE CASCADE;


--
-- Name: schools schools_principal_fk; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_principal_fk FOREIGN KEY (principal) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: student_academic_background student_academic_background_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_academic_background
    ADD CONSTRAINT student_academic_background_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_addresses student_addresses_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_addresses
    ADD CONSTRAINT student_addresses_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_admission_fees student_admission_fees_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_admission_fees
    ADD CONSTRAINT student_admission_fees_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_contacts student_contacts_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_contacts
    ADD CONSTRAINT student_contacts_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_documents student_documents_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_documents
    ADD CONSTRAINT student_documents_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_hostel student_hostel_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_hostel
    ADD CONSTRAINT student_hostel_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_transport student_transport_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.student_transport
    ADD CONSTRAINT student_transport_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: students students_classid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_classid_fkey FOREIGN KEY (classid) REFERENCES public.classes(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: students students_schoolid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_schoolid_fkey FOREIGN KEY (schoolid) REFERENCES public.schools(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: students students_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE SET NULL;


--
-- Name: users users_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rudra
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: rudra
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict BrMBPGPTEXyTHtsKl6GTP0bM0b5YGM8GrQABaLllwNCTjhtPX6WmuM2cH6BFymh

