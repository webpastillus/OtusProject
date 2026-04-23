
--Заполнение справочников
INSERT INTO "ClientType" ("Name") VALUES
('Физ. лицо'),
('ИП'),
('Самозанятый'),
('Юр. лицо');

INSERT INTO "Companies" ("Name") VALUES
('ООО "Рога и Копыта"'), 
('ООО "Ромашка"'), 
('АО "Авокадо"');

INSERT INTO "ContactInfoType" ("Name") VALUES
('Личный телефон'), 
('Рабочий телефон'), 
('Личный Email'), 
('Рабочий Email'), 
('Telegram'), 
('WhatsApp');

INSERT INTO "UserRoles" ("Name") VALUES
('Администратор'),
('Руководитель отдела продаж'),
('Руководитель отдела аналитики'),
('Старший менеджер'),
('Старший аналитик'),
('Менеджер'),
('Аналитик'),
('Менеджер стажёр'),
('Аналитик стажёр'),
('Старший разработчик'),
('Разработчик');

INSERT INTO "DealStatuses" ("Name") VALUES
('Новая'),
('В обработке'),
('Одобрена'),
('Оплачена'),
('Исполнена'),
('Закрыта');

INSERT INTO "InteractionTypes" ("Name") VALUES
('Входящий звонок'), 
('Исходящий звонок'), 
('Входящий Email'), 
('Исходящий Email'),
('Общение в мессенджерах');

INSERT INTO "Products" ("Name", "Price") VALUES
('Консультация час', 3000.00),
('Разработка сайта "Старт" час', 5000.00),
('Разработка сайта "Бизнес" час', 10000.00),
('Техническая поддержка час', 2000.00),
('Аудит сайта час', 4000.00),
('Настройка рекламы час', 3000.00),
('Обучение персонала час', 4000.00),
('Юридическая консультация час', 5000.00),
('Бухгалтерское сопровождение час', 5000.00),
('Разработка мобильного приложения час', 4000.00),
('Разработка дизайна час', 3500.00),
('Видеосъемка час', 8000.00),
('Фотосъемка час', 5000.00),
('3D печать концепт', 2000.00),
('3D печать размер XS штука', 3000.00),
('3D печать размер S штука', 4000.00),
('3D печать размер M штука', 5000.00),
('3D печать размер L штука', 6000.00),
('3D печать размер XL штука', 7000.00),
('3D печать размер XXL штука', 8000.00);

--Создаем юзеров
INSERT INTO "Users" ("FirstName", "LastName", "MiddleName", "Email", "RoleId", "CreatedDate") VALUES 
('Иван', 'Иванов', 'Иванович', 'ii.ivanov@crm.ru', 1, '2026-01-01 08:14:44'),
('Александр', 'Иванов', 'Александрович', 'aa.ivanov@crm.ru', 2, '2026-01-01 08:14:44'),
('Дмитрий', 'Петров', 'Александрович', 'da.petrov@crm.ru', 3, '2026-01-01 08:14:44'),
('Максим', 'Сидоров', 'Иванович', 'mi.sidorov@crm.ru', 4, '2026-01-01 08:14:44'),
('Андрей', 'Смирнов', 'Иванович', 'ai.smirnov@crm.ru', 5, '2026-01-01 08:14:44'),
('Сергей', 'Кузнецов', 'Петрович', 'si.kuznetsov@crm.ru', 6, '2026-01-01 08:14:44'),
('Владимир', 'Попов', 'Алексеевич', 'va.popov@crm.ru', 6, '2026-01-01 08:14:44'),
('Екатерина', 'Морозова', 'Николаевна', 'en.morozova@crm.ru', 6, '2026-01-01 08:14:44'),
('Мария', 'Алексеева', 'Ивановна', 'mi.alekseeva@crm.ru', 7, '2026-01-01 08:14:44'),
('Ольга', 'Федорова', 'Владимировна', 'ov.federova@crm.ru', 7, '2026-01-01 08:14:44'),
('Иван', 'Козлов', 'Олегович', 'io.kozlov@crm.ru', 8, '2026-01-01 08:14:44'),
('Дмитрий', 'Иванов', 'Алексеевич', 'da.ivanov@crm.ru', 10, '2026-01-01 08:14:44'),
('Андрей', 'Попов', 'Алексеевич', 'aa.popov@crm.ru', 11, '2026-01-01 08:14:44'),
('Андрей', 'Соколов', 'Олегович', 'ao.sokolov@crm.ru', 11, '2026-01-01 08:14:44');

--Создаем клиентов
INSERT INTO "Clients" ("FirstName", "LastName", "MiddleName", "Type", "CompanyId","CreatedDate") VALUES 
('Иван', 'Иванов', 'Петрович', 1, NULL, '2026-01-02 10:30:00'),
('Мария', 'Смирнова', 'Алексеевна', 1, NULL, '2026-01-02 14:45:00'),
('Петр', 'Кузнецов', 'Сергеевич', 1, NULL, '2026-01-03 09:15:00'),
('Елена', 'Попова', 'Дмитриевна', 1, NULL, '2026-01-03 10:21:00'),
('Алексей', 'Соколов', 'Владимирович', 2, NULL, '2026-01-10 11:08:00'),
('Ольга', 'Лебедева', 'Николаевна', 3, NULL, '2026-01-14 13:30:00'),
('Дмитрий', 'Козлов', 'Андреевич', 2, NULL, '2026-01-20 08:45:00'),
('Татьяна', 'Новикова', 'Игоревна', 4, 1, '2026-02-10 11:18:00'),
('Роман', 'Морозов', 'Павлович', 4, 2, '2026-02-20 06:34:00'),
('Светлана', 'Петрова', 'Юрьевна', 4, 3, '2026-03-12 09:39:00');

--Создаем контактные данные клиентов
INSERT INTO "ClientContactInfo" ("ClientId", "ContactInfoType", "ContactValue", "CreatedDate") VALUES 
-- Клиент 1 (Иван Иванов)
(1, 1, '+79161234567', '2026-01-02 10:30:00'),
(1, 3, 'ivan.ivanov@example.com', '2026-01-02 10:30:00'),
(1, 5, 'https://t.me/ivan_ivanov', '2026-01-02 10:30:00'),
-- Клиент 2 (Мария Смирнова)
(2, 1, '+79032345678', '2026-01-02 14:45:00'),
-- Клиент 3 (Петр Кузнецов)
(3, 3, 'petr.kuznetsov@yandex.ru', '2026-01-03 09:15:00'),
-- Клиент 4 (Елена Попова)
(4, 1, '+79154567890', '2026-01-03 10:21:00'),
-- Клиент 5 (Алексей Соколов)
(5, 2, '+79065678901', '2026-01-10 11:08:00'),
(5, 4, 'ip.alexey.sokolov@bk.ru', '2026-01-10 11:08:00'),
-- Клиент 6 (Ольга Лебедева)
(6, 1, '+79106789012', '2026-01-14 13:30:00'),
-- Клиент 7 (Дмитрий Козлов)
(7, 2, '+79217890123', '2026-01-20 08:45:00'),
-- Клиент 8 (Татьяна Новикова)
(8, 2, '+74998901234', '2026-02-10 11:18:00'),
(8, 4, 'tatiana.novikova@rogkop.team', '2026-02-10 11:18:00'),
-- Клиент 9 (Роман Морозов)
(9, 2, '+74991234567', '2026-02-20 06:34:00'),
(9, 4, 'roman.morozov@romashka.ru', '2026-02-20 06:34:00'),
-- Клиент 10 (Светлана Петрова)
(10, 2, '+74952345678', '2026-03-12 09:39:00'),
(10, 4, 'svetlana.petrova@avoka.do', '2026-03-12 09:39:00');

--Создаем первую сделку 
INSERT INTO "Deals" ("ClientId") VALUES (1);

--Добавляем товары
CALL "AddProductToDeal"(1,'[{"NameJS":"Консультация час", "QuantityJS":1}, 
					   		{"NameJS":"Настройка рекламы час", "QuantityJS":3}, 
					   		{"NameJS":"Фотосъемка час", "QuantityJS":1}]');
   		
--Добавляем еще товары
CALL "AddProductToDeal"(1,'[{"NameJS":"3D печать концепт", "QuantityJS":4}, 
					   		{"NameJS":"Настройка рекламы час", "QuantityJS":2}, 
					   		{"NameJS":"Фотосъемка час", "QuantityJS":3}]')		

--Закрепляем заказ
CALL "AssignDealResponsible"(1,6)

--Общение с клиентом
INSERT INTO "Interactions" ("ClientId", "UserId", "DealId", "InteractionType", "ContactId", "Duration", "Comments")
VALUES(1, 6, 1, 2, 1, 187, 'Оплата будет частями');

--Заказ одобрен
UPDATE "Deals" SET "Status"=3 WHERE "Id"=1;

--Проверка вьюх
select *
from "ClientFinancialView";

select *
from "EmployeePerformanceView";

select *
from "ActiveDealsView";

--Оплата 1
CALL "RegisterPayment"(1, 15000);
--Оплата 2
CALL "RegisterPayment"(1, 31000);

--Заказ исполнен
UPDATE "Deals" SET "Status"=5 WHERE "Id"=1;

--Проверка вьюх
select *
from "ClientFinancialView";

select *
from "EmployeePerformanceView";

select *
from "ActiveDealsView";

--Создание сделки сотрудником

CALL "CreateDealByUser"(8,7,'[{"NameJS":"3D печать концепт", "QuantityJS":4}, 
					   		{"NameJS":"Настройка рекламы час", "QuantityJS":20}, 
					   		{"NameJS":"Видеосъемка час", "QuantityJS":4}]')

INSERT INTO "Interactions" ("ClientId", "UserId", "DealId", "InteractionType", "ContactId", "Duration")
VALUES(8, 7, 2, 2, 10, 540);	

--Проверка вьюх
select *
from "ClientFinancialView";

select *
from "EmployeePerformanceView";

select *
from "ActiveDealsView";

--Копия заказа
CALL "CopyDeal"(1)		

--Проверка вьюх
select *
from "ClientFinancialView";

select *
from "EmployeePerformanceView";

select *
from "ActiveDealsView";

--Оплата 1
CALL "RegisterPayment"(2, 15000);
--Оплата 2
CALL "RegisterPayment"(2, 31000);
--Оплата 2
CALL "RegisterPayment"(2, 54000);

--SET enable_seqscan = OFF;
--SET enable_seqscan = DEFAULT;
--Запрос: Отчет по сотрудникам с суммой сделок и сравнением со средним по компании за месяц. С CTE и подзапросом
--EXPLAIN ANALYZE
WITH "EmployeeDealsStats" AS (
    --CTE: собираем статистику по каждому сотруднику
    SELECT 
        u."Id" AS "UserId",
        CONCAT(u."LastName", ' ', u."FirstName") AS "FullUserName",
        "GetUserTotalDealsSum"(u."Id",(CURRENT_TIMESTAMP AT TIME ZONE 'UTC') - INTERVAL '1 month',(CURRENT_TIMESTAMP AT TIME ZONE 'UTC')) AS "TotalDealsSum",
        COUNT(DISTINCT d."Id") AS "DealsCount",
        COUNT(DISTINCT i."Id") AS "InteractionsCount",
        COUNT(DISTINCT d."ClientId") AS "UniqueClientsCount"
    FROM "Users" u
    JOIN "Deals" d ON u."Id" = d."UserId" 
        AND d."Status" IN (3, 4, 5)
        AND d."CreatedDate" >= (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') - INTERVAL '1 month'
    JOIN "Interactions" i ON u."Id" = i."UserId"
        AND i."CreatedDate" >= (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') - INTERVAL '1 month'
    WHERE u."IsBlocked" = FALSE
    GROUP BY u."Id", u."LastName", u."FirstName"
),
"CompanyAvg" AS (
    SELECT AVG(d2."Amount") as "CompanyAvgAmount"
    FROM "Deals" d2
    WHERE d2."Status" IN (3, 4, 5)
      AND d2."CreatedDate" >= (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') - INTERVAL '1 month'
)
SELECT 
    e."UserId",
    e."FullUserName",
    e."TotalDealsSum",
    e."DealsCount",
    e."InteractionsCount",
    e."UniqueClientsCount",
    (SELECT "CompanyAvgAmount" FROM "CompanyAvg") AS "CompanyAvgAmount",
    CASE 
        WHEN e."TotalDealsSum" > (SELECT "CompanyAvgAmount" FROM "CompanyAvg") THEN 'Выше среднего'
        WHEN e."TotalDealsSum" < (SELECT "CompanyAvgAmount" FROM "CompanyAvg") THEN 'Ниже среднего'
        ELSE 'На уровне среднего'
    END AS "Rating"
FROM "EmployeeDealsStats" e
ORDER BY e."UserId";

/*
CTE Scan on "EmployeeDealsStats" e  (cost=11.67..11.70 rows=1 width=156) (actual time=0.076..0.077 rows=1.00 loops=1)
  Storage: Memory  Maximum Storage: 17kB
  Buffers: shared hit=6
  CTE EmployeeDealsStats
    ->  GroupAggregate  (cost=10.26..10.55 rows=1 width=1124) (actual time=0.068..0.068 rows=1.00 loops=1)
          Group Key: u."Id"
          Buffers: shared hit=5
          ->  Sort  (cost=10.26..10.27 rows=1 width=1048) (actual time=0.033..0.034 rows=1.00 loops=1)
                Sort Key: u."Id", d."Id"
                Sort Method: quicksort  Memory: 25kB
                Buffers: shared hit=4
                ->  Nested Loop  (cost=0.14..10.25 rows=1 width=1048) (actual time=0.028..0.029 rows=1.00 loops=1)
                      Join Filter: (u."Id" = d."UserId")
                      Buffers: shared hit=4
                      ->  Nested Loop  (cost=0.00..2.08 rows=1 width=20) (actual time=0.018..0.018 rows=1.00 loops=1)
                            Join Filter: (d."UserId" = i."UserId")
                            Buffers: shared hit=2
                            ->  Seq Scan on "Deals" d  (cost=0.00..1.05 rows=1 width=12) (actual time=0.014..0.014 rows=1.00 loops=1)
                                  Filter: (("Status" = ANY ('{3,4,5}'::integer[])) AND ("CreatedDate" >= ((CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) - '1 mon'::interval)))
                                  Rows Removed by Filter: 1
                                  Buffers: shared hit=1
                            ->  Seq Scan on "Interactions" i  (cost=0.00..1.02 rows=1 width=8) (actual time=0.003..0.003 rows=1.00 loops=1)
                                  Filter: ("CreatedDate" >= ((CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) - '1 mon'::interval))
                                  Buffers: shared hit=1
                      ->  Index Scan using "Users_pkey" on "Users" u  (cost=0.14..8.16 rows=1 width=1036) (actual time=0.009..0.009 rows=1.00 loops=1)
                            Index Cond: ("Id" = i."UserId")
                            Filter: (NOT "IsBlocked")
                            Index Searches: 1
                            Buffers: shared hit=2
  CTE CompanyAvg
    ->  Aggregate  (cost=1.05..1.06 rows=1 width=32) (actual time=0.004..0.004 rows=1.00 loops=1)
          Buffers: shared hit=1
          ->  Seq Scan on "Deals" d2  (cost=0.00..1.05 rows=1 width=16) (actual time=0.002..0.002 rows=1.00 loops=1)
                Filter: (("Status" = ANY ('{3,4,5}'::integer[])) AND ("CreatedDate" >= ((CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) - '1 mon'::interval)))
                Rows Removed by Filter: 1
                Buffers: shared hit=1
  InitPlan 3
    ->  CTE Scan on "CompanyAvg"  (cost=0.00..0.02 rows=1 width=32) (actual time=0.005..0.005 rows=1.00 loops=1)
          Storage: Memory  Maximum Storage: 17kB
          Buffers: shared hit=1
  InitPlan 4
    ->  CTE Scan on "CompanyAvg" "CompanyAvg_1"  (cost=0.00..0.02 rows=1 width=32) (actual time=0.000..0.000 rows=1.00 loops=1)
          Storage: Memory  Maximum Storage: 17kB
  InitPlan 5
    ->  CTE Scan on "CompanyAvg" "CompanyAvg_2"  (cost=0.00..0.02 rows=1 width=32) (actual time=0.000..0.000 rows=1.00 loops=1)
          Storage: Memory  Maximum Storage: 17kB
Planning Time: 0.201 ms
Execution Time: 0.165 ms
*/

/*
CTE Scan on "EmployeeDealsStats" e  (cost=26.37..26.39 rows=1 width=156) (actual time=0.053..0.054 rows=1.00 loops=1)
  Storage: Memory  Maximum Storage: 17kB
  Buffers: shared hit=9
  CTE EmployeeDealsStats
    ->  GroupAggregate  (cost=17.85..18.14 rows=1 width=1124) (actual time=0.047..0.047 rows=1.00 loops=1)
          Group Key: u."Id"
          Buffers: shared hit=7
          ->  Sort  (cost=17.85..17.85 rows=1 width=1048) (actual time=0.021..0.021 rows=1.00 loops=1)
                Sort Key: u."Id", d."Id"
                Sort Method: quicksort  Memory: 25kB
                Buffers: shared hit=6
                ->  Nested Loop  (cost=0.41..17.84 rows=1 width=1048) (actual time=0.018..0.019 rows=1.00 loops=1)
                      Buffers: shared hit=6
                      ->  Nested Loop  (cost=0.28..17.08 rows=1 width=1048) (actual time=0.013..0.014 rows=1.00 loops=1)
                            Buffers: shared hit=4
                            ->  Index Scan using "IX_Deals_Status_CreatedDate" on "Deals" d  (cost=0.14..8.16 rows=1 width=12) (actual time=0.009..0.010 rows=1.00 loops=1)
                                  Index Cond: (("Status" = ANY ('{3,4,5}'::integer[])) AND ("CreatedDate" >= ((CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) - '1 mon'::interval)))
                                  Index Searches: 1
                                  Buffers: shared hit=2
                            ->  Index Scan using "Users_pkey" on "Users" u  (cost=0.14..8.16 rows=1 width=1036) (actual time=0.003..0.003 rows=1.00 loops=1)
                                  Index Cond: ("Id" = d."UserId")
                                  Filter: (NOT "IsBlocked")
                                  Index Searches: 1
                                  Buffers: shared hit=2
                      ->  Index Scan using "IX_Interactions_CreatedDate_UserId" on "Interactions" i  (cost=0.13..0.75 rows=1 width=8) (actual time=0.004..0.004 rows=1.00 loops=1)
                            Index Cond: (("CreatedDate" >= ((CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) - '1 mon'::interval)) AND ("UserId" = u."Id"))
                            Index Searches: 1
                            Buffers: shared hit=2
  CTE CompanyAvg
    ->  Aggregate  (cost=8.16..8.17 rows=1 width=32) (actual time=0.003..0.003 rows=1.00 loops=1)
          Buffers: shared hit=2
          ->  Index Scan using "IX_Deals_Status_CreatedDate" on "Deals" d2  (cost=0.14..8.16 rows=1 width=16) (actual time=0.002..0.002 rows=1.00 loops=1)
                Index Cond: (("Status" = ANY ('{3,4,5}'::integer[])) AND ("CreatedDate" >= ((CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) - '1 mon'::interval)))
                Index Searches: 1
                Buffers: shared hit=2
  InitPlan 3
    ->  CTE Scan on "CompanyAvg"  (cost=0.00..0.02 rows=1 width=32) (actual time=0.004..0.004 rows=1.00 loops=1)
          Storage: Memory  Maximum Storage: 17kB
          Buffers: shared hit=2
  InitPlan 4
    ->  CTE Scan on "CompanyAvg" "CompanyAvg_1"  (cost=0.00..0.02 rows=1 width=32) (actual time=0.000..0.000 rows=1.00 loops=1)
          Storage: Memory  Maximum Storage: 17kB
  InitPlan 5
    ->  CTE Scan on "CompanyAvg" "CompanyAvg_2"  (cost=0.00..0.02 rows=1 width=32) (actual time=0.000..0.000 rows=1.00 loops=1)
          Storage: Memory  Maximum Storage: 17kB
Planning Time: 0.195 ms
Execution Time: 0.082 ms
 */

-- Статистика по таблицам/индесам
SELECT  *
FROM pg_stat_user_tables

SELECT *
FROM pg_stat_user_indexes


