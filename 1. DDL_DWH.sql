/* Скрипт создания DWH (схема «звезда»). */

/* 1. Создаём таблицу измерения по мастерам. */
DROP TABLE IF EXISTS dwh.d_craftsman;

CREATE TABLE IF NOT EXISTS dwh.d_craftsman (
	craftsman_id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
	craftsman_name VARCHAR NOT NULL,
	craftsman_address VARCHAR NOT NULL,
	craftsman_birthday DATE NOT NULL,
	craftsman_email VARCHAR NOT NULL,
	load_dttm TIMESTAMP NOT NULL,
	CONSTRAINT craftsman_pk PRIMARY KEY (craftsman_id)
);

/* 2. Создаём таблицу измерения по заказчикам. */
DROP TABLE IF EXISTS dwh.d_customer;

CREATE TABLE IF NOT EXISTS dwh.d_customer (
	customer_id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
	customer_name VARCHAR NULL,
	customer_address VARCHAR NULL,
	customer_birthday DATE NULL,
	customer_email VARCHAR NOT NULL,
	load_dttm TIMESTAMP NOT NULL,
	CONSTRAINT customers_pk PRIMARY KEY (customer_id)
);

/* 3. Создаём таблицу измерения по продажам. */
DROP TABLE IF EXISTS dwh.d_product;

CREATE TABLE IF NOT EXISTS dwh.d_product (
	product_id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
	product_name VARCHAR NOT NULL,
	product_description VARCHAR NOT NULL,
	product_type VARCHAR NOT NULL,
	product_price BIGINT NOT NULL,
	load_dttm TIMESTAMP NOT NULL,
	CONSTRAINT products_pk PRIMARY KEY (product_id)
);

/* 4. Создаём таблицу фактов. */
DROP TABLE IF EXISTS dwh.f_order;

CREATE TABLE IF NOT EXISTS dwh.f_order (
	order_id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
	product_id BIGINT NOT NULL,
	craftsman_id BIGINT NOT NULL,
	customer_id BIGINT NOT NULL,
	order_created_date DATE NOT NULL,
	order_completion_date DATE NOT NULL,
	order_status VARCHAR CHECK (order_status IN ('created', 'in progress', 'delivery', 'done')) NOT NULL,
	load_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT orders_pk PRIMARY KEY (order_id),
	CONSTRAINT orders_product_fk FOREIGN KEY (product_id) REFERENCES dwh.d_product (product_id) ON DELETE RESTRICT,
	CONSTRAINT orders_craftsman_fk FOREIGN KEY (craftsman_id) REFERENCES dwh.d_craftsman (craftsman_id) ON DELETE RESTRICT,
	CONSTRAINT orders_customer_fk FOREIGN KEY (customer_id) REFERENCES dwh.d_customer (customer_id) ON DELETE RESTRICT
);
