--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: provider; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA provider;


ALTER SCHEMA provider OWNER TO postgres;

--
-- Name: shop; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA shop;


ALTER SCHEMA shop OWNER TO postgres;

--
-- Name: SCHEMA shop; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA shop IS 'standard public schema';


--
-- Name: supporting_directories; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supporting_directories;


ALTER SCHEMA supporting_directories OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cart; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.cart (
    order_id integer,
    product_id integer,
    amount integer
);


ALTER TABLE shop.cart OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.customer (
    login character varying(25) NOT NULL,
    password character varying(30),
    email character varying(30),
    firstname character varying(30),
    lastname character varying(30),
    phone_number character varying(20),
    adress character varying(255),
    date_of_birth date,
    registration_date date,
    gender character varying(1)
);


ALTER TABLE shop.customer OWNER TO postgres;

--
-- Name: customer_login_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.customer_login_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.customer_login_seq OWNER TO postgres;

--
-- Name: customer_login_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.customer_login_seq OWNED BY shop.customer.login;


--
-- Name: delivery; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.delivery (
    order_id integer NOT NULL,
    sum_weight integer,
    date_of_delivery timestamp without time zone,
    delivery_price numeric(10,2),
    personnel_number integer,
    delivery_status_id integer
);


ALTER TABLE shop.delivery OWNER TO postgres;

--
-- Name: delivery_status_history; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.delivery_status_history (
    id integer NOT NULL,
    order_id integer,
    old_status_id integer,
    new_status_id integer,
    change_date timestamp without time zone
);


ALTER TABLE shop.delivery_status_history OWNER TO postgres;

--
-- Name: delivery_status_history_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.delivery_status_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.delivery_status_history_id_seq OWNER TO postgres;

--
-- Name: delivery_status_history_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.delivery_status_history_id_seq OWNED BY shop.delivery_status_history.id;


--
-- Name: employee; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.employee (
    personnel_number integer NOT NULL,
    firstname character varying(30),
    lastname character varying(30),
    email character varying(30),
    "position" character varying(30),
    phone_number character varying(20)
);


ALTER TABLE shop.employee OWNER TO postgres;

--
-- Name: employee_personnel_number_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.employee_personnel_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.employee_personnel_number_seq OWNER TO postgres;

--
-- Name: employee_personnel_number_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.employee_personnel_number_seq OWNED BY shop.employee.personnel_number;


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.order_id_seq OWNER TO postgres;

--
-- Name: order; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop."order" (
    id integer DEFAULT nextval('shop.order_id_seq'::regclass) NOT NULL,
    date_of_order timestamp without time zone,
    order_status_id integer,
    final_price numeric(10,2),
    payment_method_id integer,
    method_of_obtaining_id integer,
    personnel_number integer,
    storage_id integer,
    login character varying(25)
);


ALTER TABLE shop."order" OWNER TO postgres;

--
-- Name: order_status_history; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.order_status_history (
    id integer NOT NULL,
    order_id integer,
    old_status_id integer,
    new_status_id integer,
    change_date timestamp without time zone
);


ALTER TABLE shop.order_status_history OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.product (
    id integer NOT NULL,
    product_name character varying(30),
    price numeric(10,2),
    refund_money boolean,
    product_weight numeric(6,3),
    product_length numeric(4,1),
    product_width numeric(4,1),
    product_height numeric(4,1),
    category character varying(30),
    guarantee numeric(4,2)
);


ALTER TABLE shop.product OWNER TO postgres;

--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.product_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.product_product_id_seq OWNER TO postgres;

--
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.product_product_id_seq OWNED BY shop.product.id;


--
-- Name: quantity_in_stock; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.quantity_in_stock (
    storage_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer
);


ALTER TABLE shop.quantity_in_stock OWNER TO postgres;

--
-- Name: rating; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.rating (
    product_id integer NOT NULL,
    login_customer character varying(25),
    mark numeric(1,0),
    review text
);


ALTER TABLE shop.rating OWNER TO postgres;

--
-- Name: sale; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.sale (
    id integer NOT NULL,
    product_id integer,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    price numeric(10,2),
    amount integer
);


ALTER TABLE shop.sale OWNER TO postgres;

--
-- Name: sale_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.sale_id_seq OWNER TO postgres;

--
-- Name: sale_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.sale_id_seq OWNED BY shop.sale.id;


--
-- Name: status_history_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.status_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.status_history_id_seq OWNER TO postgres;

--
-- Name: status_history_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.status_history_id_seq OWNED BY shop.order_status_history.id;


--
-- Name: storage; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.storage (
    id integer NOT NULL,
    name character varying(30),
    adress character varying(255),
    phone_number character varying(20)
);


ALTER TABLE shop.storage OWNER TO postgres;

--
-- Name: storage_storage_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.storage_storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.storage_storage_id_seq OWNER TO postgres;

--
-- Name: storage_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.storage_storage_id_seq OWNED BY shop.storage.id;


--
-- Name: devilery_status; Type: TABLE; Schema: supporting_directories; Owner: postgres
--

CREATE TABLE supporting_directories.devilery_status (
    id integer NOT NULL,
    title character varying(30)
);


ALTER TABLE supporting_directories.devilery_status OWNER TO postgres;

--
-- Name: devilery_status_id_seq; Type: SEQUENCE; Schema: supporting_directories; Owner: postgres
--

CREATE SEQUENCE supporting_directories.devilery_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supporting_directories.devilery_status_id_seq OWNER TO postgres;

--
-- Name: devilery_status_id_seq; Type: SEQUENCE OWNED BY; Schema: supporting_directories; Owner: postgres
--

ALTER SEQUENCE supporting_directories.devilery_status_id_seq OWNED BY supporting_directories.devilery_status.id;


--
-- Name: method_of_obtaining; Type: TABLE; Schema: supporting_directories; Owner: postgres
--

CREATE TABLE supporting_directories.method_of_obtaining (
    id integer NOT NULL,
    title character varying(50)
);


ALTER TABLE supporting_directories.method_of_obtaining OWNER TO postgres;

--
-- Name: method_of_obtaining_id_seq; Type: SEQUENCE; Schema: supporting_directories; Owner: postgres
--

CREATE SEQUENCE supporting_directories.method_of_obtaining_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supporting_directories.method_of_obtaining_id_seq OWNER TO postgres;

--
-- Name: method_of_obtaining_id_seq; Type: SEQUENCE OWNED BY; Schema: supporting_directories; Owner: postgres
--

ALTER SEQUENCE supporting_directories.method_of_obtaining_id_seq OWNED BY supporting_directories.method_of_obtaining.id;


--
-- Name: order_status; Type: TABLE; Schema: supporting_directories; Owner: postgres
--

CREATE TABLE supporting_directories.order_status (
    id integer NOT NULL,
    title character varying(50)
);


ALTER TABLE supporting_directories.order_status OWNER TO postgres;

--
-- Name: order_status_id_seq; Type: SEQUENCE; Schema: supporting_directories; Owner: postgres
--

CREATE SEQUENCE supporting_directories.order_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supporting_directories.order_status_id_seq OWNER TO postgres;

--
-- Name: order_status_id_seq; Type: SEQUENCE OWNED BY; Schema: supporting_directories; Owner: postgres
--

ALTER SEQUENCE supporting_directories.order_status_id_seq OWNED BY supporting_directories.order_status.id;


--
-- Name: payment_method; Type: TABLE; Schema: supporting_directories; Owner: postgres
--

CREATE TABLE supporting_directories.payment_method (
    id integer NOT NULL,
    title character varying(50)
);


ALTER TABLE supporting_directories.payment_method OWNER TO postgres;

--
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: supporting_directories; Owner: postgres
--

CREATE SEQUENCE supporting_directories.payment_method_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supporting_directories.payment_method_id_seq OWNER TO postgres;

--
-- Name: payment_method_id_seq; Type: SEQUENCE OWNED BY; Schema: supporting_directories; Owner: postgres
--

ALTER SEQUENCE supporting_directories.payment_method_id_seq OWNED BY supporting_directories.payment_method.id;


--
-- Name: delivery_status_history id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.delivery_status_history ALTER COLUMN id SET DEFAULT nextval('shop.delivery_status_history_id_seq'::regclass);


--
-- Name: employee personnel_number; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.employee ALTER COLUMN personnel_number SET DEFAULT nextval('shop.employee_personnel_number_seq'::regclass);


--
-- Name: order_status_history id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.order_status_history ALTER COLUMN id SET DEFAULT nextval('shop.status_history_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.product ALTER COLUMN id SET DEFAULT nextval('shop.product_product_id_seq'::regclass);


--
-- Name: sale id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.sale ALTER COLUMN id SET DEFAULT nextval('shop.sale_id_seq'::regclass);


--
-- Name: storage id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.storage ALTER COLUMN id SET DEFAULT nextval('shop.storage_storage_id_seq'::regclass);


--
-- Name: devilery_status id; Type: DEFAULT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.devilery_status ALTER COLUMN id SET DEFAULT nextval('supporting_directories.devilery_status_id_seq'::regclass);


--
-- Name: method_of_obtaining id; Type: DEFAULT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.method_of_obtaining ALTER COLUMN id SET DEFAULT nextval('supporting_directories.method_of_obtaining_id_seq'::regclass);


--
-- Name: order_status id; Type: DEFAULT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.order_status ALTER COLUMN id SET DEFAULT nextval('supporting_directories.order_status_id_seq'::regclass);


--
-- Name: payment_method id; Type: DEFAULT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.payment_method ALTER COLUMN id SET DEFAULT nextval('supporting_directories.payment_method_id_seq'::regclass);


--
-- Data for Name: cart; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.cart (order_id, product_id, amount) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.customer (login, password, email, firstname, lastname, phone_number, adress, date_of_birth, registration_date, gender) FROM stdin;
\.


--
-- Data for Name: delivery; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.delivery (order_id, sum_weight, date_of_delivery, delivery_price, personnel_number, delivery_status_id) FROM stdin;
\.


--
-- Data for Name: delivery_status_history; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.delivery_status_history (id, order_id, old_status_id, new_status_id, change_date) FROM stdin;
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.employee (personnel_number, firstname, lastname, email, "position", phone_number) FROM stdin;
1	Иван	Петров	ivan.petrov@gmail.com	Курьер	70325700979
2	Игорь	Кузнецов	igor.kuznetcov@gmail.com	Менеджер по продажам	79323710985
3	Анатолий	Попов	anatolyi.popov@gmail.com	Директор отдела закупок	74957318033
4	Анастасия	Соколова	anastasiy.sokolova@gmail.com	Маркетолог	73974669611
5	Маргарита	Зайцева	margarita.zaytceva@gmail.com	Менеджер по продажам	76184836308
6	Ирина	Никитина	irina.nikitina@gmail.com	Экономист	71517799674
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop."order" (id, date_of_order, order_status_id, final_price, payment_method_id, method_of_obtaining_id, personnel_number, storage_id, login) FROM stdin;
\.


--
-- Data for Name: order_status_history; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.order_status_history (id, order_id, old_status_id, new_status_id, change_date) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.product (id, product_name, price, refund_money, product_weight, product_length, product_width, product_height, category, guarantee) FROM stdin;
\.


--
-- Data for Name: quantity_in_stock; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.quantity_in_stock (storage_id, product_id, amount) FROM stdin;
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.rating (product_id, login_customer, mark, review) FROM stdin;
\.


--
-- Data for Name: sale; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.sale (id, product_id, start_date, end_date, price, amount) FROM stdin;
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: shop; Owner: postgres
--

COPY shop.storage (id, name, adress, phone_number) FROM stdin;
1	Точка выдачи в Царицыно	Москва, ул. Михневская, 8	74997459099
2	Точка выдачи на Сходненской	Москва, ул. Свободы, 59	74997459098
3	Точка выдачи на Автозаводской	Москва, ул. Автозаводский 3-й проезд, 4	74997459097
\.


--
-- Data for Name: devilery_status; Type: TABLE DATA; Schema: supporting_directories; Owner: postgres
--

COPY supporting_directories.devilery_status (id, title) FROM stdin;
1	Ждёт обработки
2	Обрабатывается
3	Доставляется
4	В пункте самовывоза
5	Доставлен
6	Отменён
\.


--
-- Data for Name: method_of_obtaining; Type: TABLE DATA; Schema: supporting_directories; Owner: postgres
--

COPY supporting_directories.method_of_obtaining (id, title) FROM stdin;
1	Самовывоз
2	Курьерская доставка
3	Отправка заказа транспортной компанией
\.


--
-- Data for Name: order_status; Type: TABLE DATA; Schema: supporting_directories; Owner: postgres
--

COPY supporting_directories.order_status (id, title) FROM stdin;
1	Передан на обработку
2	Обрабатывается/Формируется к отправке
3	Подготовлен счёт на оплату
4	Ждите звонка от оператора
5	Едет в пункт выдачи
6	Ожидаем поставку товара
7	Отменён
8	Готов к получению
9	Передан в отдел доставки/Готовится к доставке
10	Передан курьеру
11	Передан в транспортную компанию
12	Нам не удалось с Вами связаться
13	Выполнен
\.


--
-- Data for Name: payment_method; Type: TABLE DATA; Schema: supporting_directories; Owner: postgres
--

COPY supporting_directories.payment_method (id, title) FROM stdin;
1	Банковская карта
2	Наличный расчет
3	Оплата через СБП (Систему быстрых платежей)
4	Оплата в кредит или рассрочку
\.


--
-- Name: customer_login_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.customer_login_seq', 1, false);


--
-- Name: delivery_status_history_id_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.delivery_status_history_id_seq', 1, false);


--
-- Name: employee_personnel_number_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.employee_personnel_number_seq', 6, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.order_id_seq', 1, false);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.product_product_id_seq', 1, false);


--
-- Name: sale_id_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.sale_id_seq', 1, false);


--
-- Name: status_history_id_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.status_history_id_seq', 1, false);


--
-- Name: storage_storage_id_seq; Type: SEQUENCE SET; Schema: shop; Owner: postgres
--

SELECT pg_catalog.setval('shop.storage_storage_id_seq', 3, true);


--
-- Name: devilery_status_id_seq; Type: SEQUENCE SET; Schema: supporting_directories; Owner: postgres
--

SELECT pg_catalog.setval('supporting_directories.devilery_status_id_seq', 6, true);


--
-- Name: method_of_obtaining_id_seq; Type: SEQUENCE SET; Schema: supporting_directories; Owner: postgres
--

SELECT pg_catalog.setval('supporting_directories.method_of_obtaining_id_seq', 8, true);


--
-- Name: order_status_id_seq; Type: SEQUENCE SET; Schema: supporting_directories; Owner: postgres
--

SELECT pg_catalog.setval('supporting_directories.order_status_id_seq', 13, true);


--
-- Name: payment_method_id_seq; Type: SEQUENCE SET; Schema: supporting_directories; Owner: postgres
--

SELECT pg_catalog.setval('supporting_directories.payment_method_id_seq', 4, true);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (login);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (personnel_number);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: sale sale_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.sale
    ADD CONSTRAINT sale_pkey PRIMARY KEY (id);


--
-- Name: order_status_history status_history_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.order_status_history
    ADD CONSTRAINT status_history_pkey PRIMARY KEY (id);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (id);


--
-- Name: devilery_status devilery_status_pkey; Type: CONSTRAINT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.devilery_status
    ADD CONSTRAINT devilery_status_pkey PRIMARY KEY (id);


--
-- Name: method_of_obtaining method_of_obtaining_pkey; Type: CONSTRAINT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.method_of_obtaining
    ADD CONSTRAINT method_of_obtaining_pkey PRIMARY KEY (id);


--
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (id);


--
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: supporting_directories; Owner: postgres
--

ALTER TABLE ONLY supporting_directories.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- Name: cart cart_fk; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.cart
    ADD CONSTRAINT cart_fk FOREIGN KEY (product_id) REFERENCES shop.product(id);


--
-- Name: cart cart_fk_1; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.cart
    ADD CONSTRAINT cart_fk_1 FOREIGN KEY (order_id) REFERENCES shop."order"(id);


--
-- Name: delivery delivery_delivery_status_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.delivery
    ADD CONSTRAINT delivery_delivery_status_fkey FOREIGN KEY (delivery_status_id) REFERENCES supporting_directories.devilery_status(id);


--
-- Name: delivery delivery_order_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.delivery
    ADD CONSTRAINT delivery_order_id_fkey FOREIGN KEY (order_id) REFERENCES shop."order"(id);


--
-- Name: delivery delivery_personnel_number_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.delivery
    ADD CONSTRAINT delivery_personnel_number_fkey FOREIGN KEY (personnel_number) REFERENCES shop.employee(personnel_number);


--
-- Name: delivery_status_history delivery_status_history_fk; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.delivery_status_history
    ADD CONSTRAINT delivery_status_history_fk FOREIGN KEY (order_id) REFERENCES shop."order"(id);


--
-- Name: delivery_status_history delivery_status_history_fk_1; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.delivery_status_history
    ADD CONSTRAINT delivery_status_history_fk_1 FOREIGN KEY (old_status_id) REFERENCES supporting_directories.devilery_status(id);


--
-- Name: delivery_status_history delivery_status_history_fk_2; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.delivery_status_history
    ADD CONSTRAINT delivery_status_history_fk_2 FOREIGN KEY (new_status_id) REFERENCES supporting_directories.devilery_status(id);


--
-- Name: order order_login_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop."order"
    ADD CONSTRAINT order_login_fkey FOREIGN KEY (login) REFERENCES shop.customer(login);


--
-- Name: order order_method_of_obtaining_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop."order"
    ADD CONSTRAINT order_method_of_obtaining_fkey FOREIGN KEY (method_of_obtaining_id) REFERENCES supporting_directories.method_of_obtaining(id);


--
-- Name: order order_order_status_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop."order"
    ADD CONSTRAINT order_order_status_fkey FOREIGN KEY (order_status_id) REFERENCES supporting_directories.order_status(id);


--
-- Name: order order_payment_method_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop."order"
    ADD CONSTRAINT order_payment_method_fkey FOREIGN KEY (payment_method_id) REFERENCES supporting_directories.payment_method(id);


--
-- Name: order order_personnel_number_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop."order"
    ADD CONSTRAINT order_personnel_number_fkey FOREIGN KEY (personnel_number) REFERENCES shop.employee(personnel_number);


--
-- Name: order order_storage_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop."order"
    ADD CONSTRAINT order_storage_id_fkey FOREIGN KEY (storage_id) REFERENCES shop.storage(id);


--
-- Name: quantity_in_stock quantity_in_stock_product_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.quantity_in_stock
    ADD CONSTRAINT quantity_in_stock_product_id_fkey FOREIGN KEY (product_id) REFERENCES shop.product(id);


--
-- Name: quantity_in_stock quantity_in_stock_storage_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.quantity_in_stock
    ADD CONSTRAINT quantity_in_stock_storage_id_fkey FOREIGN KEY (storage_id) REFERENCES shop.storage(id);


--
-- Name: rating rating_login_customer_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.rating
    ADD CONSTRAINT rating_login_customer_fkey FOREIGN KEY (login_customer) REFERENCES shop.customer(login);


--
-- Name: rating rating_product_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.rating
    ADD CONSTRAINT rating_product_id_fkey FOREIGN KEY (product_id) REFERENCES shop.product(id);


--
-- Name: sale sale_fk; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.sale
    ADD CONSTRAINT sale_fk FOREIGN KEY (product_id) REFERENCES shop.product(id);


--
-- Name: order_status_history status_history_fk; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.order_status_history
    ADD CONSTRAINT status_history_fk FOREIGN KEY (order_id) REFERENCES shop."order"(id);


--
-- Name: order_status_history status_history_fk_1; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.order_status_history
    ADD CONSTRAINT status_history_fk_1 FOREIGN KEY (old_status_id) REFERENCES supporting_directories.order_status(id);


--
-- Name: order_status_history status_history_fk_2; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.order_status_history
    ADD CONSTRAINT status_history_fk_2 FOREIGN KEY (new_status_id) REFERENCES supporting_directories.order_status(id);


--
-- PostgreSQL database dump complete
--

