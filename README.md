# CRM-система для малого бизнеса

## Описание проекта

Проект представляет собой базу данных для CRM-системы, разработанную на PostgreSQL. Система позволяет управлять клиентами, сделками, взаимодействиями, продуктами и платежами.

## Структура базы данных

[Project.sql](https://github.com/webpastillus/OtusProject/blob/main/Project.sql) 

### Таблицы (15)

#### ClientType - Таблица с типами клиентов (физ.лицо, ИП, юр.лицо и т.д.) 

| Поле | Тип | Описание |
|------|-----|----------|
| `Id` | SERIAL | Уникальный идентификатор (PK) |
| `Name` | VARCHAR(255) | Название типа клиента |

####`Companies` - Таблица с названиями компаний клиентов, если они являются юр.лицом

| Поле | Тип | Описание |
|------|-----|----------|
| `Id` | SERIAL | Уникальный идентификатор (PK) |
| `Name` | VARCHAR(255) | Название компании |

#### <a id="Clients"></a>`Clients` - Хранит основную информацию о клиентах компании

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор клиента (первичный ключ) |
| `FirstName` | VARCHAR(255) | NOT NULL | Имя клиента (обязательное поле) |
| `LastName` | VARCHAR(255) | NOT NULL | Фамилия клиента (обязательное поле) |
| `MiddleName` | VARCHAR(255) | NULL | Отчество клиента (не обязательное поле) |
| `Type` | INT2 | NOT NULL, FK(ClientType) | Тип клиента (обязательное поле) - справочник [`ClientType`](#ClientType) |
| `CompanyId` | INT | NULL, FK(Companies) | Id компании из которой клиент (не обязательное поле) - справочник [`Companies`](#Companies) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время создания записи (по умолчанию текущая дата и время по UTC 0) |

#### <a id="ContactInfoType"></a>`ContactInfoType` - Таблица с типами контактной информации клиентов

| Поле | Тип | Описание |
|------|-----|----------|
| `Id` | SERIAL | Уникальный идентификатор (PK) |
| `Name` | VARCHAR(255) | Название типа контактной информации клиента |

#### <a id="ClientContactInfo"></a>`ClientContactInfo` - Хранит контактную информацию о клиенте

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор записи (первичный ключ) |
| `ClientId` | INT | NOT NULL, FK(Clients) | Номер клиента (обязательное поле) - ссылка на [`Clients`](#Clients) |
| `ContactInfoType` | INT2 | NOT NULL, FK(ContactInfoType) | Тип контактной информации (обязательное поле) - справочник [`ContactInfoType`](#ContactInfoType) |
| `ContactValue` | VARCHAR(500) | NOT NULL | Контактная информация (обязательное поле) |
| `IsActual` | BOOLEAN | NOT NULL, DEFAULT TRUE | Акутальнось данной контактной информации (по умолчанию true) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время создания записи (по умолчанию текущая дата и время по UTC 0) |

#### <a id="UserRoles"></a>`UserRoles` - Таблица с ролью/должностью сотрудников в CRM

| Поле | Тип | Описание |
|------|-----|----------|
| `Id` | SERIAL | Уникальный идентификатор (PK) |
| `Name` | VARCHAR(255) | Название роли/должности сотрудников |

#### <a id="Users"></a>`Users` - Хранит информацию о сотрудниках

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор сотрудника (первичный ключ) |
| `FirstName` | VARCHAR(255) | NOT NULL | Имя сотрудника (обязательное поле) |
| `LastName` | VARCHAR(255) | NOT NULL | Фамилия сотрудника (обязательное поле) |
| `MiddleName` | VARCHAR(255) | NULL | Отчество сотрудника (не обязательное поле) |
| `Email` | VARCHAR(100) | NOT NULL | Email сотрудника (обязательное поле) |
| `RoleId` | INT2 | NOT NULL, FK(UserRoles) | Должностью сотрудника (обязательное поле) - справочник [`UserRoles`](#UserRoles) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время создания записи (по умолчанию текущая дата и время по UTC 0) |
| `IsBlocked` | BOOLEAN | NOT NULL, DEFAULT FALSE | Заблокирован/уволен сотрудник (по умолчанию false) |

#### <a id="DealStatuses"></a>`DealStatuses` - Хранит информацию о сотрудниках

| Поле | Тип | Описание |
|------|-----|----------|
| `Id` | SERIAL | Уникальный идентификатор (PK) |
| `Name` | VARCHAR(50) | Название статуса |

#### <a id="Deals"></a>`Deals` - Хранит информацию по заявокам клиентов

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор заявки (первичный ключ) |
| `ClientId` | INT | NOT NULL, FK(Clients) | Номер клиента (обязательное поле) - ссылка на [`Clients`](#Clients) |
| `UserId` | INT | NULL, FK(Users) | Номер сотрудника (обязательное поле) - ссылка на [`Users`](#Users) |
| `Status` | INT2 | NOT NULL, DEFAULT 1, FK(DealStatuses) | Статус заявки (по умолчанию 1) - ссылка на [`DealStatuses`](#DealStatuses) |
| `Amount` | NUMERIC(12,2) | NOT NULL, DEFAULT 0 | Сумма заказа/заявки (по умолчанию 0) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0) |
| `ApprovedDate` | TIMESTAMP | NULL | Дата и время одобрения заявки - заполнение через триггер [`TrgrSetAdditionalDateDeals`](#TrgrSetAdditionalDateDeals) |
| `AcceptDate` | TIMESTAMP | NULL | Дата и время принятия/полной оплаты заявки - заполнение через триггер [`TrgrSetAdditionalDateDeals`](#TrgrSetAdditionalDateDeals) |
| `ClosedDate` | TIMESTAMP | NULL | Дата и время закрытия заявки - заполнение через триггер [`TrgrSetAdditionalDateDeals`](#TrgrSetAdditionalDateDeals) |

#### <a id="DealsHistory"></a>`DealsHistory` - Хранит информацию об истории изменения статуса заявки

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор записи (первичный ключ) |
| `DealId` | INT | NOT NULL, FK(Deals) | Номер заявки (обязательное поле) - ссылка на [`Deals`](#Deals) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0) |
| `Status` | INT2 | NOT NULL, FK(DealStatuses) | Статус заявки (обязательное поле) - ссылка на [`DealStatuses`](#DealStatuses) |

#### <a id="InteractionTypes"></a>`InteractionTypes` - Таблица с типами взаимодействия с клиентами

| Поле | Тип | Описание |
|------|-----|----------|
| `Id` | SERIAL | Уникальный идентификатор (PK) |
| `Name` | VARCHAR(50) | Название типа взаимодействия |

#### <a id="Interactions"></a>`Interactions` - Хранит информацию об истории взаимодействия с клиентами

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор записи (первичный ключ) |
| `ClientId` | INT | NOT NULL, FK(Clients) | Номер клиента (обязательное поле) - ссылка на [`Clients`](#Clients) |
| `UserId` | INT | NOT NULL, FK(Users) | Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0) |
| `DealId` | INT | NOT NULL, FK(Deals) | Номер заявки (обязательное поле) - ссылка на [`Deals`](#Deals) |
| `InteractionType` | INT2 | NOT NULL, FK(InteractionTypes) | Тип взаимодействия (обязательное поле) - ссылка на [`InteractionTypes`](#InteractionTypes) |
| `ContactId` | INT | NOT NULL, FK(ClientContactInfo) | Номер записи контакта клиента (обязательное поле) - ссылка на [`ClientContactInfo`](#ClientContactInfo) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время создания заявки (по умолчанию текущая дата и время по UTC 0) |
| `Duration` | INT2 | NULL | Длительность разговора в секундах (не обязательное поле) |
| `Comments` | VARCHAR(2000) | NULL | Комментарий от сотрудника по итогу взаимодействия (не обязательное поле) |

#### <a id="Products"></a>`Products` - Таблица с продуктами/услугами и их ценой

| Поле | Тип | Описание |
|------|-----|----------|
| `Id` | SERIAL | Уникальный идентификатор (PK) |
| `Name` | VARCHAR(100) | Название продукта |
| `Price` | NUMERIC(10,2) | Цена продукта |

#### <a id="DealProducts"></a>`DealProducts` - Хранит информацию о продуктах в заказах клиента

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор записи (первичный ключ) |
| `DealId` | INT | NOT NULL, FK(Deals) | Номер заявки (обязательное поле) - ссылка на [`Deals`](#Deals) |
| `ProductId` | INT | NOT NULL, FK(Products) | Номер продукта (обязательное поле) - ссылка на [`Products`](#Products) |
| `Quantity` | INT | DEFAULT 1 | Количество позиций в заказе (по умолчанию 1) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время добавления продукта в заказ (по умолчанию текущая дата и время по UTC 0) |

#### <a id="Payments"></a>`Payments` - Хранит информацию о продуктах в заказах клиента

| Поле | Тип | Ограничение | Описание |
|------|-----|-------------|----------|
| `Id` | SERIAL | PRIMARY KEY | Уникальный идентификатор записи (первичный ключ) |
| `DealId` | INT | NOT NULL, FK(Deals) | Номер заявки (обязательное поле) - ссылка на [`Deals`](#Deals) |
| `CreatedDate` | TIMESTAMP | DEFAULT UTC | Дата и время платежа (по умолчанию текущая дата и время по UTC 0) |
| `PaymentSum` | NUMERIC(10,2) | NOT NULL | Сумма платежа (обязательное поле) |

### ER-диаграмма

[ProjectCRM.erd](https://github.com/webpastillus/OtusProject/blob/main/ProjectCRM.erd) 

![ProjectCRM.png](https://github.com/webpastillus/OtusProject/blob/main/ProjectCRM.png)


## Функции (3 + 2 триггерные)

| Название | Назначение | Пример вызова |
|---------|------------|---------------|
| <a id="GetDealTotalSum"></a>`GetDealTotalSum` | Подсчёт общей суммы сделки | `SELECT "GetDealTotalSum"(1);` |
| <a id="GetDealTotalPaidSum"></a>`GetDealTotalPaidSum` | Подсчёт оплаченной суммы по сделке | `SELECT "GetDealTotalPaidSum"(1);` |
| <a id="GetUserTotalDealsSum"></a>`GetUserTotalDealsSum` | Сумма сделок сотрудника за период или за все время | `SELECT "GetUserTotalDealsSum"(1, '2024-01-01', '2024-12-31');` или `SELECT "GetUserTotalDealsSum"(1);` |
| <a id="SetAdditionalDateDeals"></a>`SetAdditionalDateDeals` | Для заполения даты одобрения, полной оплаты, закрытия при смене статуса сделки  | при UPDATE Deals |
| <a id="LogDealStatusChange"></a>`LogDealStatusChange` | Изменение статуса сделки с автоматической записью в табилцу историй изменения статусов | при INSERT и UPDATE Deals |


## Хранимые процедуры (5)

| Название | Назначение | Пример вызова |
|-----------|------------|---------------|
| <a id="AddProductToDeal"></a>`AddProductToDeal` | Добавление продуктов в сделку | `CALL "AddProductToDeal"(1, '[{"NameJS":"Ноутбук","QuantityJS":2}]');` |
| <a id="RegisterPayment"></a>`RegisterPayment` | Внесение платежа по сделке | `CALL "RegisterPayment"(1, 1, 5000.00);` |
| <a id="AssignDealResponsible"></a>`AssignDealResponsible` | Назначение ответственного на сделку | `CALL "AssignDealResponsible"(1, 2);` |
| <a id="CreateDealByUser"></a>`CreateDealByUser` | Создание сделки сотрудником | `CALL "CreateDealByUser"(1, 2, '[{"NameJS":"Ноутбук","QuantityJS":2}]');` |
| <a id="CopyDeal"></a>`CopyDeal` | Копирование сделки с продуктами | `CALL "CopyDeal"(1);` |
 
## Триггеры (2)

| Название | Назначение |
|---------------|------------|
| <a id="TrgrSetAdditionalDateDeals"></a>`TrgrSetAdditionalDateDeals` | Для заполения даты одобрения, полной оплаты, закрытия при смене статуса сделки. Вызывается при UPDATE Deals |
| <a id="TrgrLogDealStatusChange"></a>`TrgrLogDealStatusChange` | Изменение статуса сделки с автоматической записью в табилцу историй изменения статусов. Вызывается при INSERT и UPDATE Deals |

## Представления (Views) (3)

| Название | Назначение |
|---------------|------------|
| `ActiveDealsView` | Активные сделки с деталями (клиент, менеджер, статус, сумма, дата, сумма оплаты) |
| `EmployeePerformanceView` | Эффективность менеджеров (менеджер, роль, кол-во сделок, сумма сделок, кол-во взаимодействий, кол-во уникальных клиентов) |
| `ClientFinancialView` | Финансовый отчёт по клиентам (клиент, кол-во заказов, сумма заказов, сумма оплат, дата последнего заказа) |

# Дополнительная информация

## Заполнение БД и тесты

[Project_insert.sql](https://github.com/webpastillus/OtusProject/blob/main/Project_insert.sql) 

## Описание 

Таблицы справочники [`ClientType`](#ClientType), [`Companies`](#Companies), [`ContactInfoType`](#ContactInfoType), [`UserRoles`](#UserRoles), [`DealStatuses`](#DealStatuses), [`InteractionTypes`](#InteractionTypes), [`Products`](#Products), а так же пользователей CRM [`Users`](#Users) меняются через IT-команду (разработка). У сотрудиников CRM нет возможности вносить изменения в данные таблицы через CRM.

Клиентов [`Clients`](#Clients) и их контактные данные [`ClientContactInfo`](#ClientContactInfo) заполняются через INSERT, специальных функций для этого нет. Таблицы могут измениться если:
1. Зарегистрировался новый клиент (INSERT в две таблицы)
2. Сотрудник создал клиента самостоятельно (INSERT в две таблицы)(возможно оформить как процедуру)
3. Клиент или сотрудник изменили контактные данные (UPDATE в [`ClientContactInfo`](#ClientContactInfo))(возможно оформить как процедуру)

Для сделок [`Deals`](#Deals) имеется 3 способа их создания:
1. Клиент создает новую через CRM (INSERT). Клиент может не добавлять продукты сразу, а добавить их позже. Заказ будет в статусе 1 - Новый и его необходимо обработать менеджером.
2. Клиент копирует свой существующий заказ со всем продуктами в прошлом заказе (Вызов [`CALL "CopyDeal"();`](#CopyDeal)). При этом данный заказ будет в статусе 1 - Новый и его необходимо обработать менеджером.
3. Сотрудник по указанию клиента формирует заказ (Вызов [`CALL "CreateDealByUser"();`](#CreateDealByUser))). Данный заказ будет сразу закреплен на сотрудником, который его создал, а так же переведен в статус 3 - Одобрен. (возможно добавить в процедуру автоматическое добавление взаимодейсвия). В данной процедуре имеется входящее JSONВ поле в формате - `[{"NameJS":"Ноутбук","QuantityJS":2}]`. 

При каждом изменении статуса в [`Deals`](#Deals) вызывается триггер [`TrgrLogDealStatusChange`](#TrgrLogDealStatusChange) для записи истории изменения статуса в [`DealsHistory`](#DealsHistory). Одобрение (Статус - 3) и закрытие (Статус - 5) заказов происходит через UPDATE [`Deals`](#Deals). Так же при изменении статуса вызывается триггер [`TrgrSetAdditionalDateDeals`](#TrgrSetAdditionalDateDeals), который заполняет поля ApprovedDate (Дата и время одобрения заявки - Статус 3), AcceptDate (Дата и время принятия/полной оплаты заявки - Статус 4) и ClosedDate (Дата и время закрытия заявки - Статус 5 или 6)

Для добавления продуктов в [`DealProducts`](#DealProducts) имеется процедура [`CALL "AddProductToDeal"();`](#AddProductToDeal). Это основной механизм добавления продуктов в сделку. (Есть момент с удалением продуктов. Нужно вызвать DELETE в [`DealProducts`](#DealProducts) и UPDATE "Amount" в [`Deals`](#Deals) с использованием функции [`GetDealTotalSum`](#GetDealTotalSum). Это можно вынести в отдельную процедуру) В данной процедуре имеется входящее JSONВ поле в формате - `[{"NameJS":"Ноутбук","QuantityJS":2}]`.

Закрепление за сотрудником сделки выполняется через процедуру [`CALL "AssignDealResponsible"();`](#AssignDealResponsible). При этом по сделке обновляется статус на 2 - В обработке. Взаимодействия [`Interactions`](#Interactions) добавяются через INSERT. 

Оплата выполняется через процедуру [`CALL "RegisterPayment"();`](#RegisterPayment). Проверка на натуральное число происходит в коде CRM (можно вынести в БД). Если внесена полная оплата, то обновляем статус на 4 - Оплачен. 
