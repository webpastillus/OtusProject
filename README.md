# CRM-система для малого бизнеса

## Описание проекта

Проект представляет собой базу данных для CRM-системы, разработанную на PostgreSQL. Система позволяет управлять клиентами, сделками, взаимодействиями, продуктами и платежами.

## Структура базы данных

[Project.sql](https://github.com/webpastillus/OtusProject/blob/main/Project.sql) 

### Таблицы (15)

| Таблица | Назначение |
|---------|------------|
| <a id="ClientContactInfo"></a>`ClientContactInfo` | Контактная информация клиентов |
| <a id="ClientType"></a>`ClientType` | Типы клиентов (физ.лицо, ИП, юр.лицо и т.д.) |
| <a id="Clients"></a>`Clients` | Основная информация о клиентах |
| <a id="Companies"></a>`Companies` | Компании клиентов |
| <a id="ContactInfoType"></a>`ContactInfoType` | Типы контактной информации |
| <a id="DealProducts"></a>`DealProducts` | Связь заявок с продуктами |
| <a id="DealStatuses"></a>`DealStatuses` | Статусы заявок |
| <a id="Deals"></a>`Deals` | Основная информация о заявках |
| <a id="DealsHistory"></a>`DealsHistory` | История изменения статусов |
| <a id="InteractionTypes"></a>`InteractionTypes` | Типы взаимодействий с клиентами |
| <a id="Interactions"></a>`Interactions` | История взаимодействий |
| <a id="Payments"></a>`Payments` | Информация об оплатах |
| <a id="Products"></a>`Products` | Продукты и услуги |
| <a id="UserRoles"></a>`UserRoles` | Роли сотрудников |
| <a id="Users"></a>`Users` | Информация о сотрудниках |

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
| <a id="AddProductToDeal"></a>`AddProductToDeal` | Добавление продуктов в сделку | `CALL "AddProductToDeal"(1, '[{"NameJS":"Ноутбук","QuantityJS":2}]');` |
| <a id="RegisterPayment"></a>`RegisterPayment` | Внесение платежа по сделке | `CALL "RegisterPayment"(1, 1, 5000.00);` |
| <a id="AssignDealResponsible"></a>`AssignDealResponsible` | Назначение ответственного на сделку | `CALL "AssignDealResponsible"(1, 2);` |
| <a id="CreateDealByUser"></a>`CreateDealByUser` | Создание сделки сотрудником | `CALL "CreateDealByUser"(1, 2, '[{"NameJS":"Ноутбук","QuantityJS":2}]');` |
| <a id="CopyDeal"></a>`CopyDeal` | Копирование сделки с продуктами | `CALL "CopyDeal"(1);` |
 
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

Таблицы справочники [`ClientType`](#ClientType), [`Companies`](#Companies), [`ContactInfoType`](#ContactInfoType), [`UserRoles`](#UserRoles), [`DealStatuses`](#DealStatuses), [`InteractionTypes`](#InteractionTypes), [`Products`](#Products), а так же пользователей CRM [`Users`](#Users) меняются через IT-команду (разработка). У сотрудиников CRM нет возможности вносить изменения в данные таблицы через CRM.

Клиентов [`Clients`](#Clients) и их контактные данные [`ClientContactInfo`](#ClientContactInfo) заполняются через INSERT, специальных функций для этого нет. Таблицы могут измениться если:
1. Зарегистрировался новый клиент (INSERT в две таблицы)
2. Сотрудник создал клиента самостоятельно (INSERT в две таблицы)(возможно оформить как процедуру)
3. Клиент или сотрудник изменили контактные данные (UPDATE в [`ClientContactInfo`](#ClientContactInfo))(возможно оформить как процедуру)

Для сделок [`Deals`](#Deals) имеется 3 способа их создания:
1. Клиент создает новую через CRM (INSERT)
2. Клиент копирует свой существующий заказ со всем продуктами в прошлом заказе (INSERT)
