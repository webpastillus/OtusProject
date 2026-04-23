# CRM-система для малого бизнеса

## Описание проекта

Проект представляет собой базу данных для CRM-системы, разработанную на PostgreSQL. Система позволяет управлять клиентами, сделками, взаимодействиями, продуктами и платежами.

## Структура базы данных

[Project.sql](https://github.com/webpastillus/OtusProject/blob/main/Project.sql) 

### Таблицы (15)

| Таблица | Назначение |
|---------|------------|
| `ClientContactInfo` | Контактная информация клиентов |
| <a id="ClientType"></a>`ClientType` | Типы клиентов (физ.лицо, ИП, юр.лицо и т.д.) |
| `Clients` | Основная информация о клиентах |
| `Companies` | Компании клиентов |
| `ContactInfoType` | Типы контактной информации |
| `DealProducts` | Связь заявок с продуктами |
| `DealStatuses` | Статусы заявок |
| `Deals` | Основная информация о заявках |
| `DealsHistory` | История изменения статусов |
| `InteractionTypes` | Типы взаимодействий с клиентами |
| `Interactions` | История взаимодействий |
| `Payments` | Информация об оплатах |
| `Products` | Продукты и услуги |
| `UserRoles` | Роли сотрудников |
| `Users` | Информация о сотрудниках |

### ER-диаграмма

[ProjectCRM.erd](https://github.com/webpastillus/OtusProject/blob/main/ProjectCRM.erd) 

![postgres - ProjectCRM - public.png](https://github.com/webpastillus/OtusProject/blob/main/postgres%20-%20ProjectCRM%20-%20public.png)


## Функции (3 + 2 триггерные)

| Название | Назначение | Пример вызова |
|---------|------------|---------------|
| `GetDealTotalSum` | Подсчёт общей суммы сделки | `SELECT "GetDealTotalSum"(1);` |
| `GetDealTotalPaidSum` | Подсчёт оплаченной суммы по сделке | `SELECT "GetDealTotalPaidSum"(1);` |
| `GetUserTotalDealsSum` | Сумма сделок сотрудника за период или за все время | `SELECT "GetUserTotalDealsSum"(1, '2024-01-01', '2024-12-31');` или `SELECT "GetUserTotalDealsSum"(1);` |
| `SetAdditionalDateDeals` | Для заполения даты одобрения, полной оплаты, закрытия при смене статуса сделки  | при UPDATE Deals |
| `LogDealStatusChange` | Изменение статуса сделки с автоматической записью в табилцу историй изменения статусов | при INSERT и UPDATE Deals |


## Хранимые процедуры (5)

| Название | Назначение | Пример вызова |
|-----------|------------|---------------|
| `AddProductToDeal` | Добавление продуктов в сделку | `CALL "AddProductToDeal"(1, '[{"NameJS":"Ноутбук","QuantityJS":2}]');` |
| `RegisterPayment` | Внесение платежа по сделке | `CALL "RegisterPayment"(1, 1, 5000.00);` |
| `AssignDealResponsible` | Назначение ответственного на сделку | `CALL "AssignDealResponsible"(1, 2);` |
| `CreateDealByUser` | Создание сделки сотрудником | `CALL "CreateDealByUser"(1, 2, '[{"NameJS":"Ноутбук","QuantityJS":2}]');` |
| `CopyDeal` | Копирование сделки с продуктами | `CALL "CopyDeal"(1);` |
 
## Триггеры (2)

| Название | Назначение |
|---------------|------------|
| `TrgrSetAdditionalDateDeals` | Для заполения даты одобрения, полной оплаты, закрытия при смене статуса сделки. Вызывается при UPDATE Deals |
| `TrgrLogDealStatusChange` | Изменение статуса сделки с автоматической записью в табилцу историй изменения статусов. Вызывается при INSERT и UPDATE Deals |

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

Таблицы справочники  [`ClientType`](#ClientType)
