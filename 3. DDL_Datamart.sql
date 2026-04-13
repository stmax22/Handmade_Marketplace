/* Скрипт создания витрин данных и таблиц инкрементальных загрузок. */

/* 1. Создаем витрину данных по мастерам. */
DROP TABLE IF EXISTS dwh.craftsman_report_datamart;

CREATE TABLE IF NOT EXISTS dwh.craftsman_report_datamart (
    id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL, -- Идентификатор записи
    craftsman_id BIGINT NOT NULL, -- Идентификатор мастера
    craftsman_name VARCHAR NOT NULL, -- Ф.И.О. мастера
    craftsman_address VARCHAR NOT NULL, -- Адрес мастера
    craftsman_birthday DATE NOT NULL, -- Дата рождения мастера
    craftsman_email VARCHAR NOT NULL, -- Электронная почта мастера
    craftsman_money NUMERIC(15,2) NOT NULL, -- Сумма, которую заработал мастер (-10 % на платформы) за месяц
    platform_money BIGINT NOT NULL, -- Сумма, которую заработала платформа от продаж мастера за месяц
    count_order BIGINT NOT NULL, -- Количество заказов у мастера за месяц
    avg_price_order NUMERIC(10,2) NOT NULL, -- Средняя стоимость одного заказа у мастера за месяц
    avg_age_customer NUMERIC(3,1) NOT NULL, -- Средний возраст покупателей
    median_time_order_completed NUMERIC(10,1), -- Медианное время в днях от момента создания заказа до его завершения за месяц
    top_product_category VARCHAR NOT NULL, -- Самая популярная категория товаров у этого мастера за месяц
    count_order_created BIGINT NOT NULL, -- Количество созданных заказов за месяц
    count_order_in_progress BIGINT NOT NULL, -- Количество заказов в процессе изготовки за месяц
    count_order_delivery BIGINT NOT NULL, -- Количество заказов в доставке за месяц
    count_order_done BIGINT NOT NULL, -- Количество завершённых заказов за месяц
    count_order_not_done BIGINT NOT NULL, -- Количество незавершённых заказов за месяц
    report_period VARCHAR NOT NULL, -- Отчётный период год и месяц
    CONSTRAINT craftsman_report_datamart_pk PRIMARY KEY (id)
);

/* 2. Создаем таблицу инкрементальных загрузок по мастерам. */
DROP TABLE IF EXISTS dwh.load_dates_craftsman_report_datamart;

CREATE TABLE IF NOT EXISTS dwh.load_dates_craftsman_report_datamart (
    id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
    load_dttm DATE NOT NULL, -- Дата обновления
    CONSTRAINT load_dates_craftsman_report_datamart_pk PRIMARY KEY (id)
);

/* 3. Создаем витрину данных по заказчикам. */
DROP TABLE IF EXISTS dwh.customer_report_datamart;

CREATE TABLE IF NOT EXISTS dwh.customer_report_datamart (
    id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,  -- Идентификатор записи
    customer_id BIGINT NOT NULL, -- Идентификатор заказчика
    customer_name VARCHAR NOT NULL, -- Ф.И.О. заказчика
    customer_address VARCHAR NOT NULL, -- Адрес заказчика
    customer_birthday DATE NOT NULL, -- Дата рождения заказчика
    customer_email VARCHAR NOT NULL, -- Электронная почта заказчика
    customer_money NUMERIC(15,2) NOT NULL, -- Сумма, которую потратил заказчик
    platform_money BIGINT NOT NULL, -- Сумма, которую заработала платформа от покупок заказчика за месяц (10 % от суммы, которую потратил заказчик)
    count_order BIGINT NOT NULL, -- Количество заказов у заказчика за месяц
    avg_price_order NUMERIC(10,2) NOT NULL, -- Средняя стоимость одного заказа у заказчика за месяц
    median_time_order_completed NUMERIC(10,1), -- Медианное время в днях от момента создания заказа до его завершения за месяц
    top_product_category VARCHAR NOT NULL, -- Самая популярная категория товаров у этого заказчика за месяц
    top_craftsman_id BIGINT NOT NULL, -- Идентификатор самого популярного мастера ручной работы у заказчика
    count_order_created BIGINT NOT NULL, -- Количество созданных заказов за месяц
    count_order_in_progress BIGINT NOT NULL, -- Количество заказов в процессе изготовки за месяц
    count_order_delivery BIGINT NOT NULL, -- Количество заказов в доставке за месяц
    count_order_done BIGINT NOT NULL, -- Количество завершённых заказов за месяц
    count_order_not_done BIGINT NOT NULL, -- Количество незавершённых заказов за месяц
    report_period VARCHAR NOT NULL, -- Отчётный период год и месяц
    CONSTRAINT customer_report_datamart_pk PRIMARY KEY (id)
);

/* 4. Создаем таблицу инкрементальных загрузок по заказчикам. */
DROP TABLE IF EXISTS dwh.load_dates_customer_report_datamart;

CREATE TABLE IF NOT EXISTS dwh.load_dates_customer_report_datamart (
    id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
    load_dttm DATE NOT NULL, -- Дата обновления
    CONSTRAINT load_dates_customer_report_datamart_pk PRIMARY KEY (id)
);
