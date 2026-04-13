# Маркетплейс товаров ручной работы

## Задачи проекта
Необходимо построить хранилище данных (DWH) на основе данных из нескольких источников, создать витрины данных для бизнес-аналитики и реализовать инкрементальную загрузку данных.

## Описание источников данных

### Схема source1
Схема содержит широкую таблицу с денормализованными данными.

#### Таблица craft_market_wide
| Поле | Тип | Описание |
|------|-----|----------|
| `order_id` | `bigint` | Идентификатор заказа |
| `order_created_date` | `date` | Дата создания заказа |
| `order_completion_date` | `date` | Дата завершения заказа |
| `order_status` | `varchar` | Статус заказа (created, in progress, delivery, done) |
| `craftsman_id` | `bigint` | Идентификатор мастера |
| `craftsman_name` | `varchar` | Ф.И.О. мастера |
| `craftsman_address` | `varchar` | Адрес мастера |
| `craftsman_birthday` | `date` | Дата рождения мастера |
| `craftsman_email` | `varchar` | Электронная почта мастера |
| `product_id` | `bigint` | Идентификатор товара |
| `product_name` | `varchar` | Название товара |
| `product_description` | `varchar` | Описание товара |
| `product_type` | `varchar` | Тип/категория товара |
| `product_price` | `bigint` | Цена товара |
| `customer_id` | `bigint` | Идентификатор заказчика |
| `customer_name` | `varchar` | Ф.И.О. заказчика |
| `customer_address` | `varchar` | Адрес заказчика |
| `customer_birthday` | `date` | Дата рождения заказчика |
| `customer_email` | `varchar` | Электронная почта заказчика |

### Схема source2
Схема содержит две ненормализованные таблицы.

#### Таблица craft_market_masters_products
| Поле | Тип | Описание |
|------|-----|----------|
| `craftsman_id` | `bigint` | Идентификатор мастера |
| `craftsman_name` | `varchar` | Ф.И.О. мастера |
| `craftsman_address` | `varchar` | Адрес мастера |
| `craftsman_birthday` | `date` | Дата рождения мастера |
| `craftsman_email` | `varchar` | Электронная почта мастера |
| `product_id` | `bigint` | Идентификатор товара |
| `product_name` | `varchar` | Название товара |
| `product_description` | `varchar` | Описание товара |
| `product_type` | `varchar` | Тип/категория товара |
| `product_price` | `bigint` | Цена товара |

#### Таблица craft_market_orders_customers
| Поле | Тип | Описание |
|------|-----|----------|
| `order_id` | `bigint` | Идентификатор заказа |
| `order_created_date` | `date` | Дата создания заказа |
| `order_completion_date` | `date` | Дата завершения заказа |
| `order_status` | `varchar` | Статус заказа |
| `product_id` | `bigint` | Идентификатор товара |
| `craftsman_id` | `bigint` | Идентификатор мастера |
| `customer_id` | `bigint` | Идентификатор заказчика |
| `customer_name` | `varchar` | Ф.И.О. заказчика |
| `customer_address` | `varchar` | Адрес заказчика |
| `customer_birthday` | `date` | Дата рождения заказчика |
| `customer_email` | `varchar` | Электронная почта заказчика |

### Схема source3
Схема содержит три нормализованные таблицы.

#### Таблица craft_market_craftsmans
| Поле | Тип | Описание |
|------|-----|----------|
| `craftsman_id` | `bigint` | Идентификатор мастера |
| `craftsman_name` | `varchar` | Ф.И.О. мастера |
| `craftsman_address` | `varchar` | Адрес мастера |
| `craftsman_birthday` | `date` | Дата рождения мастера |
| `craftsman_email` | `varchar` | Электронная почта мастера |

#### Таблица craft_market_customers
| Поле | Тип | Описание |
|------|-----|----------|
| `customer_id` | `bigint` | Идентификатор заказчика |
| `customer_name` | `varchar` | Ф.И.О. заказчика |
| `customer_address` | `varchar` | Адрес заказчика |
| `customer_birthday` | `date` | Дата рождения заказчика |
| `customer_email` | `varchar` | Электронная почта заказчика |

#### Таблица craft_market_orders
| Поле | Тип | Описание |
|------|-----|----------|
| `order_id` | `bigint` | Идентификатор заказа |
| `product_id` | `bigint` | Идентификатор товара |
| `craftsman_id` | `bigint` | Идентификатор мастера |
| `customer_id` | `bigint` | Идентификатор заказчика |
| `order_created_date` | `date` | Дата создания заказа |
| `order_completion_date` | `date` | Дата завершения заказа |
| `order_status` | `varchar` | Статус заказа |
| `product_name` | `varchar` | Название товара |
| `product_description` | `varchar` | Описание товара |
| `product_type` | `varchar` | Тип/категория товара |
| `product_price` | `bigint` | Цена товара |

### Схема external_source
Схема содержит данные от нового внешнего источника, который требуется интегрировать в хранилище.

#### Таблица craft_products_orders
| Поле | Тип | Описание |
|------|-----|----------|
| `order_id` | `bigint` | Идентификатор заказа |
| `order_created_date` | `date` | Дата создания заказа |
| `order_completion_date` | `date` | Дата завершения заказа |
| `order_status` | `varchar` | Статус заказа |
| `craftsman_id` | `bigint` | Идентификатор мастера |
| `craftsman_name` | `varchar` | Ф.И.О. мастера |
| `craftsman_address` | `varchar` | Адрес мастера |
| `craftsman_birthday` | `date` | Дата рождения мастера |
| `craftsman_email` | `varchar` | Электронная почта мастера |
| `product_id` | `bigint` | Идентификатор товара |
| `product_name` | `varchar` | Название товара |
| `product_description` | `varchar` | Описание товара |
| `product_type` | `varchar` | Тип/категория товара |
| `product_price` | `bigint` | Цена товара |
| `customer_id` | `bigint` | Идентификатор заказчика |

#### Таблица customers
| Поле | Тип | Описание |
|------|-----|----------|
| `customer_id` | `bigint` | Идентификатор заказчика |
| `customer_name` | `varchar` | Ф.И.О. заказчика |
| `customer_address` | `varchar` | Адрес заказчика |
| `customer_birthday` | `date` | Дата рождения заказчика |
| `customer_email` | `varchar` | Электронная почта заказчика |

## Создание схемы и таблиц DWH
Создание схемы и таблиц хранилища данных находится в файле [1. DDL_DWH.sql](https://github.com/stmax22/Handmade_Marketplace/blob/f8bcd3f0c0783ddea124afe2747e92ea066dfe22/1.%20DDL_DWH.sql).

### Схема DWH
Схема хранит обработанные данные в модели "Звезда".
![](https://github.com/stmax22/Handmade_Marketplace/blob/f8bcd3f0c0783ddea124afe2747e92ea066dfe22/Diagram.png)

### Таблица d_craftsman
Таблица измерения, хранящая информацию о мастерах ручной работы.
| Поле | Тип | Описание |
|------|-----|----------|
| `craftsman_id` | `bigint` | Идентификатор мастера, первичный ключ |
| `craftsman_name` | `varchar` | Ф.И.О. мастера |
| `craftsman_address` | `varchar` | Адрес мастера |
| `craftsman_birthday` | `date` | Дата рождения мастера |
| `craftsman_email` | `varchar` | Электронная почта мастера |
| `load_dttm` | `timestamp` | Дата и время загрузки записи |

### Таблица d_customer
Таблица измерения, хранящая информацию о заказчиках.
| Поле | Тип | Описание |
|------|-----|----------|
| `customer_id` | `bigint` | Идентификатор заказчика, первичный ключ |
| `customer_name` | `varchar` | Ф.И.О. заказчика |
| `customer_address` | `varchar` | Адрес заказчика |
| `customer_birthday` | `date` | Дата рождения заказчика |
| `customer_email` | `varchar` | Электронная почта заказчика |
| `load_dttm` | `timestamp` | Дата и время загрузки записи |

### Таблица d_product
Таблица измерения, хранящая информацию о товарах.
| Поле | Тип | Описание |
|------|-----|----------|
| `product_id` | `bigint` | Идентификатор товара, первичный ключ |
| `product_name` | `varchar` | Название товара |
| `product_description` | `varchar` | Описание товара |
| `product_type` | `varchar` | Тип/категория товара |
| `product_price` | `bigint` | Цена товара |
| `load_dttm` | `timestamp` | Дата и время загрузки записи |

### Таблица f_order
Таблица фактов, хранящая информацию о заказах.
| Поле | Тип | Описание |
|------|-----|----------|
| `order_id` | `bigint` | Идентификатор заказа, первичный ключ |
| `product_id` | `bigint` | Внешний ключ на таблицу d_product |
| `craftsman_id` | `bigint` | Внешний ключ на таблицу d_craftsman |
| `customer_id` | `bigint` | Внешний ключ на таблицу d_customer |
| `order_created_date` | `date` | Дата создания заказа |
| `order_completion_date` | `date` | Дата завершения заказа |
| `order_status` | `varchar` | Статус заказа (created, in progress, delivery, done) |
| `load_dttm` | `timestamp` | Дата и время загрузки записи |

## Заполнение таблиц DWH данными
Заполнение таблиц измерений и фактов данными из всех источников находится в файле [2. DML_DWH.sql](https://github.com/stmax22/Handmade_Marketplace/blob/f8bcd3f0c0783ddea124afe2747e92ea066dfe22/2.%20DML_DWH.sql).

## Создание витрин данных
Создание витрин данных и таблиц для инкрементальной загрузки находится в файле [3. DDL_Datamart.sql](https://github.com/stmax22/Handmade_Marketplace/blob/f8bcd3f0c0783ddea124afe2747e92ea066dfe22/3.%20DDL_Datamart.sql).

### Таблица craftsman_report_datamart
Витрина данных по мастерам ручной работы за отчётные периоды.
| Поле | Тип | Описание |
|------|-----|----------|
| `id` | `bigint` | Идентификатор записи, первичный ключ |
| `craftsman_id` | `bigint` | Идентификатор мастера |
| `craftsman_name` | `varchar` | Ф.И.О. мастера |
| `craftsman_address` | `varchar` | Адрес мастера |
| `craftsman_birthday` | `date` | Дата рождения мастера |
| `craftsman_email` | `varchar` | Электронная почта мастера |
| `craftsman_money` | `numeric(15,2)` | Сумма, которую заработал мастер (-10 % на платформы) за месяц |
| `platform_money` | `bigint` | Сумма, которую заработала платформа от продаж мастера за месяц |
| `count_order` | `bigint` | Количество заказов у мастера за месяц |
| `avg_price_order` | `numeric(10,2)` | Средняя стоимость одного заказа у мастера за месяц |
| `avg_age_customer` | `numeric(3,1)` | Средний возраст покупателей |
| `median_time_order_completed` | `numeric(10,1)` | Медианное время в днях от момента создания заказа до его завершения за месяц |
| `top_product_category` | `varchar` | Самая популярная категория товаров у этого мастера за месяц |
| `count_order_created` | `bigint` | Количество созданных заказов за месяц |
| `count_order_in_progress` | `bigint` | Количество заказов в процессе изготовки за месяц |
| `count_order_delivery` | `bigint` | Количество заказов в доставке за месяц |
| `count_order_done` | `bigint` | Количество завершённых заказов за месяц |
| `count_order_not_done` | `bigint` | Количество незавершённых заказов за месяц |
| `report_period` | `varchar` | Отчётный период год и месяц |

### Таблица load_dates_craftsman_report_datamart
Таблица для отслеживания дат инкрементальных загрузок витрины по мастерам.
| Поле | Тип | Описание |
|------|-----|----------|
| `id` | `bigint` | Идентификатор записи, первичный ключ |
| `load_dttm` | `date` | Дата последней загрузки |

### Таблица customer_report_datamart
Витрина данных по заказчикам за отчётные периоды.
| Поле | Тип | Описание |
|------|-----|----------|
| `id` | `bigint` | Идентификатор записи, первичный ключ |
| `customer_id` | `bigint` | Идентификатор заказчика |
| `customer_name` | `varchar` | Ф.И.О. заказчика |
| `customer_address` | `varchar` | Адрес заказчика |
| `customer_birthday` | `date` | Дата рождения заказчика |
| `customer_email` | `varchar` | Электронная почта заказчика |
| `customer_money` | `numeric(15,2)` | Сумма, которую потратил заказчик |
| `platform_money` | `bigint` | Сумма, которую заработала платформа от покупок заказчика за месяц (10 % от суммы, которую потратил заказчик) |
| `count_order` | `bigint` | Количество заказов у заказчика за месяц |
| `avg_price_order` | `numeric(10,2)` | Средняя стоимость одного заказа у заказчика за месяц |
| `median_time_order_completed` | `numeric(10,1)` | Медианное время в днях от момента создания заказа до его завершения за месяц |
| `top_product_category` | `varchar` | Самая популярная категория товаров у этого заказчика за месяц |
| `top_craftsman_id` | `bigint` | Идентификатор самого популярного мастера ручной работы у заказчика |
| `count_order_created` | `bigint` | Количество созданных заказов за месяц |
| `count_order_in_progress` | `bigint` | Количество заказов в процессе изготовки за месяц |
| `count_order_delivery` | `bigint` | Количество заказов в доставке за месяц |
| `count_order_done` | `bigint` | Количество завершённых заказов за месяц |
| `count_order_not_done` | `bigint` | Количество незавершённых заказов за месяц |
| `report_period` | `varchar` | Отчётный период год и месяц |

### Таблица load_dates_customer_report_datamart
Таблица для отслеживания дат инкрементальных загрузок витрины по заказчикам.
| Поле | Тип | Описание |
|------|-----|----------|
| `id` | `bigint` | Идентификатор записи, первичный ключ |
| `load_dttm` | `date` | Дата последней загрузки |

## Заполнение витрин данных

### Витрина по мастерам
Заполнение витрины `craftsman_report_datamart` находится в файле [4. DML_Datamart_craftsman.sql](https://github.com/stmax22/Handmade_Marketplace/blob/f8bcd3f0c0783ddea124afe2747e92ea066dfe22/4.%20DML_Datamart_craftsman.sql).

Скрипт выполняет инкрементальный расчёт:
- Определение дельты изменений на основе даты последней загрузки
- Расчёт агрегатных показателей
- Определение топовой категории товаров с использованием оконной функции RANK()
- Вставка новых записей (INSERT)
- Обновление существующих записей (UPDATE)
- Запись даты загрузки в таблицу отслеживания

### Витрина по заказчикам
Заполнение витрины `customer_report_datamart` находится в файле [5. DML_Datamart_customer.sql](https://github.com/stmax22/Handmade_Marketplace/blob/f8bcd3f0c0783ddea124afe2747e92ea066dfe22/5.%20DML_Datamart_customer.sql).

Скрипт выполняет инкрементальный расчёт:
- Определение дельты изменений на основе даты последней загрузки
- Расчёт агрегатных показателей
- Определение топовой категории товаров с использованием оконной функции RANK()
- Определение самого популярного мастера с использованием оконной функции ROW_NUMBER()
- Вставка новых записей (INSERT)
- Обновление существующих записей (UPDATE)
- Запись даты загрузки в таблицу отслеживания

## Архитектура решения

Проект реализует полный цикл ETL-процесса:

1. **Extract** — извлечение данных из 4 источников (source1, source2, source3, external_source)
2. **Transform** — трансформация данных в модель "Звезда"
3. **Load** — инкрементальная загрузка в DWH
4. **Datamart** — построение аналитических витрин
