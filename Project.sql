-- Создание таблиц

--create database "ProjectCRM"

CREATE TABLE "ClientType" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL
);
COMMENT ON TABLE "ClientType" IS 'Таблица с типами клиентов';

CREATE TABLE "Companies" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL
);
COMMENT ON TABLE "Companies" IS 'Таблица с названиями компаний клиентов, если они являются юр.лицом';

CREATE TABLE "Clients" (
    "Id" SERIAL PRIMARY KEY,
    "FirstName" VARCHAR(255) NOT NULL,
    "LastName" VARCHAR(255) NOT NULL,
    "MiddleName" VARCHAR(255),
    "Type" INT2 NOT NULL REFERENCES "ClientType" ("Id"),
    "CompanyId" INT REFERENCES "Companies" ("Id"),
    "CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') 
);
COMMENT ON TABLE "Clients" IS 'Хранит основную информацию о клиентах компании';
COMMENT ON COLUMN "Clients"."Id" IS 'Уникальный идентификатор клиента (первичный ключ)';
COMMENT ON COLUMN "Clients"."FirstName" IS 'Имя клиента (обязательное поле)';
COMMENT ON COLUMN "Clients"."LastName" IS 'Фамилия клиента (обязательное поле)';
COMMENT ON COLUMN "Clients"."MiddleName" IS 'Отчество клиента (не обязательное поле)';
COMMENT ON COLUMN "Clients"."Type" IS 'Тип клиента (обязательное поле) - справочник ClientType';
COMMENT ON COLUMN "Clients"."CompanyId" IS 'Id компании из которой клиент (не обязательное поле) - справочник Companies';
COMMENT ON COLUMN "Clients"."CreatedDate" IS 'Дата и время создания записи (по умолчанию текущая дата и время по UTC 0)';

CREATE TABLE "ContactInfoType" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL
);
COMMENT ON TABLE "ContactInfoType" IS 'Таблица с типами контактной информации клиентов';

CREATE TABLE "ClientContactInfo" (
    "Id" SERIAL PRIMARY KEY,
    "ClientId" INT NOT NULL REFERENCES "Clients" ("Id"),
    "ContactInfoType" INT2 NOT NULL REFERENCES "ContactInfoType" ("Id"),
    "ContactValue" VARCHAR(500) NOT NULL,
    "IsActual" BOOLEAN NOT NULL DEFAULT TRUE,
	"CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') 
);
COMMENT ON TABLE "ClientContactInfo" IS 'Хранит контактную информацию о клиенте';
COMMENT ON COLUMN "ClientContactInfo"."Id" IS 'Уникальный идентификатор записи (первичный ключ)';
COMMENT ON COLUMN "ClientContactInfo"."ClientId" IS 'Номер клиента (обязательное поле) - ссылка на Clients';
COMMENT ON COLUMN "ClientContactInfo"."ContactInfoType" IS 'Тип контактной информации (обязательное поле) - справочник ContactInfoType';
COMMENT ON COLUMN "ClientContactInfo"."ContactValue" IS 'Контактная информация (обязательное поле)';
COMMENT ON COLUMN "ClientContactInfo"."IsActual" IS 'Акутальнось данной контактной информации (по умолчанию true)';
COMMENT ON COLUMN "ClientContactInfo"."CreatedDate" IS 'Дата и время создания записи (по умолчанию текущая дата и время по UTC 0)';

CREATE TABLE "UserRoles" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(50) NOT NULL
);
COMMENT ON TABLE "UserRoles" IS 'Таблица с ролью/должностью сотрудников в CRM';

CREATE TABLE "Users" (
    "Id" SERIAL PRIMARY KEY,
    "FirstName" VARCHAR(255) NOT NULL,
    "LastName" VARCHAR(255) NOT NULL,
    "MiddleName" VARCHAR(255),
    "Email" VARCHAR(100) NOT NULL,
    "RoleId" INT2 NOT NULL REFERENCES "UserRoles" ("Id"),
    "CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'),
    "IsBlocked" BOOLEAN NOT null DEFAULT FALSE
);
COMMENT ON TABLE "Users" IS 'Хранит информацию о сотрудниках';
COMMENT ON COLUMN "Users"."Id" IS 'Уникальный идентификатор сотрудника (первичный ключ)';
COMMENT ON COLUMN "Users"."FirstName" IS 'Имя сотрудника (обязательное поле)';
COMMENT ON COLUMN "Users"."LastName" IS 'Фамилия сотрудника (обязательное поле)';
COMMENT ON COLUMN "Users"."MiddleName" IS 'Отчество сотрудника (не обязательное поле)';
COMMENT ON COLUMN "Users"."Email" IS 'Email сотрудника (обязательное поле)';
COMMENT ON COLUMN "Users"."RoleId" IS 'Должностью сотрудника (обязательное поле) - справочник UserRoles';
COMMENT ON COLUMN "Users"."CreatedDate" IS 'Дата и время создания записи (по умолчанию текущая дата и время по UTC 0)';
COMMENT ON COLUMN "Users"."IsBlocked" IS 'Заблокирован/уволен сотрудник (по умолчанию false)';

CREATE TABLE "DealStatuses" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(50) NOT NULL
);
COMMENT ON TABLE "DealStatuses" IS 'Таблица со статусам заявок';

CREATE TABLE "Deals" (
    "Id" SERIAL PRIMARY KEY,
    "ClientId" INT NOT NULL REFERENCES "Clients" ("Id"),
    "UserId" INT REFERENCES "Users" ("Id"),
    "Status" INT2 NOT NULL DEFAULT 1 REFERENCES "DealStatuses"("Id"),
    "Amount" NUMERIC(12,2) NOT NULL DEFAULT 0,
    "CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'),
    "ApprovedDate" TIMESTAMP,
    "AcceptDate" TIMESTAMP,
    "ClosedDate" TIMESTAMP
);
COMMENT ON TABLE "Deals" IS 'Хранит информацию по заявокам клиентов';
COMMENT ON COLUMN "Deals"."Id" IS 'Уникальный идентификатор заявки (первичный ключ)';
COMMENT ON COLUMN "Deals"."ClientId" IS 'Номер клиента (обязательное поле) - ссылка на Clients';
COMMENT ON COLUMN "Deals"."UserId" IS 'Номер сотрудника (обязательное поле) - ссылка на Users';
COMMENT ON COLUMN "Deals"."Status" IS 'Статус заявки (по умолчанию 1) - ссылка на DealStatuses';
COMMENT ON COLUMN "Deals"."Amount" IS 'Сумма заказа/заявки (по умолчанию 0)';
COMMENT ON COLUMN "Deals"."CreatedDate" IS 'Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0)';
COMMENT ON COLUMN "Deals"."ApprovedDate" IS 'Дата и время одобрения заявки - заполнение через триггер';
COMMENT ON COLUMN "Deals"."AcceptDate" IS 'Дата и время принятия/полной оплаты заявки - заполнение через триггер';
COMMENT ON COLUMN "Deals"."ClosedDate" IS 'Дата и время закрытия заявки - заполнение через триггер';

CREATE TABLE "DealsHistory" (
    "Id" SERIAL PRIMARY KEY,
    "DealId" INT NOT NULL REFERENCES "Deals" ("Id"),
    "CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'),
    "Status" INT2 NOT NULL REFERENCES "DealStatuses"("Id")
);
COMMENT ON TABLE "DealsHistory" IS 'Хранит информацию об истории изменения статуса заявки';
COMMENT ON COLUMN "DealsHistory"."Id" IS 'Уникальный идентификатор записи (первичный ключ)';
COMMENT ON COLUMN "DealsHistory"."DealId" IS 'Номер заявки (обязательное поле) - ссылка на Deals';
COMMENT ON COLUMN "DealsHistory"."CreatedDate" IS 'Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0)';
COMMENT ON COLUMN "DealsHistory"."Status" IS 'Статус заявки (обязательное поле) - ссылка на DealStatuses';

CREATE TABLE "InteractionTypes" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(50) NOT NULL
);
COMMENT ON TABLE "InteractionTypes" IS 'Таблица с типами взаимодействия с клиентами';

CREATE TABLE "Interactions" (
    "Id" SERIAL PRIMARY KEY,
    "ClientId" INT NOT NULL REFERENCES "Clients" ("Id"),
    "UserId" INT NOT NULL REFERENCES "Users" ("Id"),
    "DealId" INT NOT NULL REFERENCES "Deals" ("Id"),
    "InteractionType" INT2 NOT NULL REFERENCES "InteractionTypes" ("Id"),
    "ContactId" INT NOT NULL REFERENCES "ClientContactInfo" ("Id"),
    "CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'),
    "Duration" INT2,
    "Comments" VARCHAR(2000)
);
COMMENT ON TABLE "Interactions" IS 'Хранит информацию об истории взаимодействия с клиентами';
COMMENT ON COLUMN "Interactions"."Id" IS 'Уникальный идентификатор записи (первичный ключ)';
COMMENT ON COLUMN "Interactions"."ClientId" IS 'Номер клиента (обязательное поле) - ссылка на Clients';
COMMENT ON COLUMN "Interactions"."UserId" IS 'Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0)';
COMMENT ON COLUMN "Interactions"."DealId" IS 'Номер заявки (обязательное поле) - ссылка на Deals';
COMMENT ON COLUMN "Interactions"."InteractionType" IS 'Тип взаимодействия (обязательное поле) - ссылка на InteractionTypes';
COMMENT ON COLUMN "Interactions"."ContactId" IS 'Номер записи контакта клиента (обязательное поле) - ссылка на ClientContactInfo';
COMMENT ON COLUMN "Interactions"."CreatedDate" IS 'Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0)';
COMMENT ON COLUMN "Interactions"."Duration" IS 'Длительность разговора (не обязательное поле)';
COMMENT ON COLUMN "Interactions"."Comments" IS 'Комментарий от сотрудника по итогу взаимодействия (не обязательное поле)';

CREATE TABLE "Products" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL,
    "Price" NUMERIC(10,2) NOT NULL
);
COMMENT ON TABLE "Products" IS 'Таблица с продуктами/услугами и их ценой';

CREATE TABLE "DealProducts" (
    "Id" SERIAL PRIMARY KEY,
    "DealId" INT NOT NULL REFERENCES "Deals"("Id"),
    "ProductId" INT NOT NULL REFERENCES "Products"("Id"),
    "Quantity" INT DEFAULT 1,
    "CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')
);
COMMENT ON TABLE "DealProducts" IS 'Хранит информацию о продуктах в заказах клиента';
COMMENT ON COLUMN "DealProducts"."Id" IS 'Уникальный идентификатор записи (первичный ключ)';
COMMENT ON COLUMN "DealProducts"."DealId" IS 'Номер заявки (обязательное поле) - ссылка на Deals';
COMMENT ON COLUMN "DealProducts"."ProductId" IS 'Номер продукта (обязательное поле) - ссылка на Products';
COMMENT ON COLUMN "DealProducts"."Quantity" IS 'Количество позиций в заказе (по умолчанию 1)';
COMMENT ON COLUMN "DealProducts"."CreatedDate" IS 'Дата и время добавления продукта в заказ (по умолчанию текущая дата и время по UTC 0)';

CREATE TABLE "Payments" (
    "Id" SERIAL PRIMARY KEY,
    "DealId" INT NOT NULL REFERENCES "Deals"("Id"),
    "CreatedDate" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'),
    "PaymentSum" NUMERIC(10,2) NOT NULL
);
COMMENT ON TABLE "Payments" IS 'Хранит информацию об оплатах заказов';
COMMENT ON COLUMN "Payments"."Id" IS 'Уникальный идентификатор записи (первичный ключ)';
COMMENT ON COLUMN "Payments"."DealId" IS 'Номер заявки (обязательное поле) - ссылка на Deals';
COMMENT ON COLUMN "Payments"."CreatedDate" IS 'Дата и время платежа (по умолчанию текущая дата и время по UTC 0)';
COMMENT ON COLUMN "Payments"."PaymentSum" IS 'Сумма платежа (обязательное поле)';

--Индекс 1: Фильтрация сделок по сотруднику и статусу и дате
CREATE INDEX "IX_Deals_Status_CreatedDate_UserId" ON "Deals" ("UserId", "Status", "CreatedDate");

--Индекс 2: Фильтрация сделок по дате создания
CREATE INDEX "IX_Deals_Status_CreatedDate" ON "Deals" ("Status", "CreatedDate");

--Индекс 3: Фильтрация платежей по сделке
CREATE INDEX "IX_Payments_DealId" ON "Payments" ("DealId");

--Индекс 4: Фильтрация продуктов в сделке
CREATE INDEX "IX_DealProducts_DealId" ON "DealProducts" ("DealId");

--Индекс 5: Фильтрация взаимодействий по клиенту и сделке
CREATE INDEX "IX_Interactions_ClientId_DealId" ON "Interactions" ("ClientId", "DealId");

--Индекс 6: Фильтрация взаимодействий по сотруднику и дате
CREATE INDEX "IX_Interactions_CreatedDate_UserId" ON "Interactions" ("CreatedDate", "UserId");

--Индекс 7: Уникальный индекс для предотвращения дублей (увеличиваем кол-во в Quantity)
CREATE UNIQUE INDEX "UQ_DealProducts_DealId_ProductId" ON "DealProducts" ("DealId", "ProductId");

--Индекс 8: Уникальный индекс для предотвращения дублей компаний
CREATE UNIQUE INDEX "UQ_Companies_Name" ON "Companies" ("Name");

--Индекс 9: Уникальный индекс для предотвращения дублей email сотрадников
CREATE UNIQUE INDEX "UQ_Users_Email" ON "Users" ("Email");

--Функция 1: Подсчет общей суммы сделки
CREATE OR REPLACE FUNCTION "GetDealTotalSum"(
    p_DealId INT
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN COALESCE(SUM(p."Price" * dp."Quantity"), 0)
    FROM "DealProducts" dp
    JOIN "Products" p ON dp."ProductId" = p."Id"
    WHERE dp."DealId" = p_DealId;
END;
$$;

--Функция 2: Подсчет общей оплаченной суммы по сделке
CREATE OR REPLACE FUNCTION "GetDealTotalPaidSum"(
    p_DealId INT
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN COALESCE(SUM("PaymentSum"), 0)
    FROM "Payments"
    WHERE "DealId" = p_DealId;
END;
$$;

--Функция 3: Получения общей суммы сделок по сотруднику
CREATE OR REPLACE FUNCTION "GetUserTotalDealsSum"(
    p_UserId INT,
    p_DateFrom TIMESTAMP DEFAULT NULL,
    p_DateTo TIMESTAMP DEFAULT NULL
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN COALESCE(SUM(d."Amount"), 0)
    FROM "Deals" d
    WHERE d."UserId" = p_UserId
      AND d."Status" IN (3, 4, 5) 
      AND (p_DateFrom IS NULL OR d."CreatedDate" >= p_DateFrom)
      AND (p_DateTo IS NULL OR d."CreatedDate" <= p_DateTo);
END;
$$;

--Процедура 1: Добавление продуктов в сделку с пересчетом суммы
CREATE OR REPLACE PROCEDURE "AddProductToDeal"(
    p_DealId INT,
    p_Products JSONB
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_NewSum NUMERIC(12,2);
BEGIN

    --Добавляем все продукты
    INSERT INTO "DealProducts" ("DealId", "ProductId", "Quantity")
    SELECT 
        p_DealId,
        p."Id",
        (elem->>'QuantityJS')::INT
    FROM jsonb_array_elements(p_Products) AS elem
    JOIN "Products" p ON p."Name" = elem->>'NameJS'
    ON CONFLICT ("DealId", "ProductId") 
    DO UPDATE SET "Quantity" = "DealProducts"."Quantity" + EXCLUDED."Quantity";
    
    -- Пересчитываем сумму
    SELECT "GetDealTotalSum"(p_DealId) INTO v_NewSum;

    UPDATE "Deals" 
    SET "Amount" = v_NewSum
    WHERE "Id" = p_DealId;

	RAISE NOTICE 'Продукт(ы) добавлен(ы) в сделку %. Новая сумма сделки: %', p_DealId, v_NewSum;
END;
$$;

--Процедура 2: Внесение платежа по сделке
CREATE OR REPLACE PROCEDURE "RegisterPayment"(
    p_DealId INT,
    p_ClientId INT,
    p_PaymentSum DECIMAL(10,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_DealAmount DECIMAL(12,2);
    v_TotalPaid DECIMAL(12,2);
BEGIN

    --Регистрируем платеж
    INSERT INTO "Payments" ("DealId", "ClientId", "PaymentSum")
    VALUES (p_DealId, p_ClientId, p_PaymentSum);
    
    --Получаем общую сумму сделки
    SELECT "Amount" INTO v_DealAmount
    FROM "Deals" 
    WHERE "Id" = p_DealId;
    
	--Получаем общую оплаченную сумму
	SELECT "GetDealTotalPaidSum"(p_DealId) INTO v_TotalPaid;

    --Если оплачена вся сумма - обновляем статус на 4
    IF v_TotalPaid >= v_DealAmount THEN
        -- Меняем статус сделки = 4
        UPDATE "Deals" 
        SET "Status" = 4
        WHERE "Id" = p_DealId;     
        
        RAISE NOTICE 'Сделка % полностью оплачена. Статус сделки изменен.', p_DealId;
	ELSE 
    	RAISE NOTICE 'Платеж % зачислен в сделку %. Осталось отплатить: %', p_PaymentSum, p_DealId, v_DealAmount-v_TotalPaid;
    END IF;
  
END;
$$;

--Процедура 3: Назначение ответственного сотрудника на сделку
CREATE OR REPLACE PROCEDURE "AssignDealResponsible"(
    p_DealId INT,
    p_UserId INT
)
LANGUAGE plpgsql
AS $$
BEGIN
         
    -- Назначаем ответственного и меняем статус на 2
    UPDATE "Deals" 
    SET "UserId" = p_UserId,
        "Status" = 2
    WHERE "Id" = p_DealId;
    
    RAISE NOTICE 'Сделке % назначен ответственный', p_DealId;
END;
$$;

--Процедура 4: Создание сделки сотрудником
CREATE OR REPLACE PROCEDURE "CreateDealByUser"(
    p_ClientId INT,
    p_UserId INT,
    p_Products JSONB
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_DealId INT;
BEGIN
   
    --Создаем сделку
    INSERT INTO "Deals" ("ClientId")
    VALUES (p_ClientId)
    RETURNING "Id" INTO v_DealId;

	RAISE NOTICE 'Создана сделка %', v_DealId;

    --Назначаем ответственного сотрудника (статус 1 менаяем на 2)
    CALL "AssignDealResponsible"(v_DealId, p_UserId);
    
	--Добавляем продукты в сделку
    CALL "AddProductToDeal"(v_DealId, p_Products);

	--Заказ одобрен
	UPDATE "Deals" 
    SET "Status" = 3
    WHERE "Id" = v_DealId;

END;
$$;

--Процедура 5: Копирование сделки со всеми продуктами
CREATE OR REPLACE PROCEDURE "CopyDeal"(
    p_DealId INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_ClientId INT;
	v_NewDealId INT;
BEGIN

    --Копируем сделку
    INSERT INTO "Deals" ("ClientId")
    SELECT "ClientId"
    FROM "Deals"
    WHERE "Id" = p_DealId
    RETURNING "Id" INTO v_NewDealId;

    -- Копируем продукты
    INSERT INTO "DealProducts" ("DealId", "ProductId", "Quantity")
    SELECT v_NewDealId, "ProductId", "Quantity"
    FROM "DealProducts"
    WHERE "DealId" = p_DealId;    
    
    RAISE NOTICE 'Создана копия сделки. Новая сделка ID: % (исходная: %)', v_NewDealId, p_DealId;
END;
$$;

--Триггерная функция 1. Для заполения ApprovedDate, AcceptDate и ClosedDate из Deals (можно это делать и из кода CRM) 
CREATE OR REPLACE FUNCTION "SetAdditionalDateDeals"()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

	IF OLD."Status" != NEW."Status" THEN
        
        --Статус 3 - устанавливаем ApprovedDate
        IF NEW."Status" = 3 AND OLD."ApprovedDate" IS NULL THEN
            NEW."ApprovedDate" = (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::TIMESTAMP;
        END IF;
        
        --Статус 4 - устанавливаем AcceptDate
        IF NEW."Status" = 4 AND OLD."AcceptDate" IS NULL THEN
            NEW."AcceptDate" = (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::TIMESTAMP;
        END IF;
        
        --Статус 5 или 6: устанавливаем ClosedDate
        IF NEW."Status" IN (5, 6) AND OLD."ClosedDate" IS NULL THEN
            NEW."ClosedDate" = (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::TIMESTAMP;
        END IF;

	END IF;
    
    RETURN NEW;
END;
$$;

-- Создаем триггер для UPDATE
CREATE TRIGGER "TrgrSetAdditionalDateDeals"
BEFORE UPDATE ON "Deals"
FOR EACH ROW
EXECUTE FUNCTION "SetAdditionalDateDeals"();

--Триггерная функция 2. Изменение статуса сделки с автоматической записью в DealsHistory
CREATE OR REPLACE FUNCTION "LogDealStatusChange"()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- При INSERT: создаем первую запись в истории
    IF TG_OP = 'INSERT' THEN
        INSERT INTO "DealsHistory" ("DealId", "Status")
        VALUES (NEW."Id", NEW."Status");       
    
    -- При UPDATE: проверяем, изменился ли статус
    ELSE 
		IF TG_OP = 'UPDATE' THEN
	        IF OLD."Status" != NEW."Status" THEN
	            INSERT INTO "DealsHistory" ("DealId", "Status")
	            VALUES (NEW."Id", NEW."Status");    
	        END IF;
    	END IF;
	END IF;
    
    RETURN NEW;
END;
$$;

-- Создаем триггер на INSERT и UPDATE
CREATE TRIGGER "TrgrLogDealStatusChange"
AFTER INSERT OR UPDATE OF "Status" ON "Deals"
FOR EACH ROW
EXECUTE FUNCTION "LogDealStatusChange"();

--View 1: Активные сделки
CREATE OR REPLACE VIEW "ActiveDealsView" as
SELECT 
    d."Id" AS "DealId",
    CONCAT(c."LastName", ' ', c."FirstName") AS "ClientFullName",
    CONCAT(u."LastName", ' ', u."FirstName") AS "UserFullName",
    ds."Name" AS "StatusName",
    d."Amount" AS "DealAmount",
    d."CreatedDate",
    "GetDealTotalPaidSum"(d."Id") as "DealTotalPaidSum"
FROM "Deals" d
JOIN "Clients" c ON d."ClientId" = c."Id"
LEFT JOIN "Users" u ON d."UserId" = u."Id"
JOIN "DealStatuses" ds ON d."Status" = ds."Id"
WHERE d."Status" NOT IN (5, 6)
ORDER BY d."Id";

--View 2: Эффективность сотрудников за все время
CREATE OR REPLACE VIEW "EmployeePerformanceView" as
SELECT 
	u."Id" AS "UserId",
    CONCAT(u."LastName", ' ', u."FirstName") AS "FullUserName",
    u."Email",
    ur."Name" AS "RoleName",
    COUNT(DISTINCT d."Id") AS "DealsCount",
    "GetUserTotalDealsSum"(u."Id") AS "TotalDealsSum",
    COUNT(DISTINCT i."Id") AS "InteractionsCount",
    COUNT(DISTINCT d."ClientId") AS "UniqueClientsCount"
FROM "Users" u
JOIN "UserRoles" ur ON u."RoleId" = ur."Id"
left JOIN "Deals" d ON u."Id" = d."UserId" AND d."Status" IN (3, 4, 5)
left JOIN "Interactions" i ON u."Id" = i."UserId"
WHERE u."IsBlocked" = false and u."RoleId" in (4,6)
GROUP BY u."Id", u."LastName", u."FirstName", u."Email", ur."Name"
ORDER BY u."Id";


--View 3: Финансовый отчет по клиентам
CREATE OR REPLACE VIEW "ClientFinancialView" as
SELECT 
    c."Id" AS "ClientId",
    CONCAT(c."LastName", ' ', c."FirstName") AS "ClientFullName",
    ct."Name" AS "ClientType",
    comp."Name" AS "ClientCompanyName",
    COUNT(DISTINCT d."Id") AS "TotalDeals",
    SUM(d."Amount") AS "TotalDealsAmount",
    SUM(p."PaymentSum") as "TotalPaidSum",   
    MAX(d."CreatedDate") AS "LastDealDate"
FROM "Clients" c
JOIN "ClientType" ct ON c."Type" = ct."Id"
LEFT JOIN "Companies" comp ON c."CompanyId" = comp."Id"
LEFT JOIN "Deals" d ON c."Id" = d."ClientId"
LEFT JOIN LATERAL (
    SELECT 
        SUM("PaymentSum") AS "PaymentSum"
    FROM "Payments" p1
    WHERE p1."DealId" = d."Id" 
) p ON TRUE
GROUP BY c."Id", c."LastName", c."FirstName", c."MiddleName", ct."Name", comp."Name"
ORDER BY c."Id";

-- Роль 1: Администратор (полный доступ)
CREATE ROLE crm_admin WITH LOGIN PASSWORD 'Admin123!@#';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO crm_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO crm_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO crm_admin;
GRANT CREATE ON SCHEMA public TO crm_admin;
GRANT crm_admin TO current_user WITH ADMIN OPTION;
GRANT ALL PRIVILEGES ON SCHEMA public TO crm_admin;

-- Роль 2: Аналитик (только чтение отчетов и представлений)
CREATE ROLE crm_analyst WITH LOGIN PASSWORD 'Analyst789&*(';
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO crm_analyst;
