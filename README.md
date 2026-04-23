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
3. Сотрудник по указанию клиента формирует заказ (Вызов [`CALL "CreateDealByUser"();`](#CreateDealByUser))). Данный заказ будет сразу закреплен на сотрудником, который его создал, а так же переведен в статус 3 - Одобрен. (возможно добавить в процедуру автоматическое добавление взаимодейсвия)

При каждом изменении статуса в [`Deals`](#Deals) вызывается триггер [`TrgrLogDealStatusChange`](#TrgrLogDealStatusChange) для записи истории изменения статуса в [`DealsHistory`](#DealsHistory). Одобрение (Статус - 3) и закрытие (Статус - 5) заказов происходит через UPDATE [`Deals`](#Deals). Так же при изменении статуса вызывается триггер [`TrgrSetAdditionalDateDeals`](#TrgrSetAdditionalDateDeals), который заполняет поля ApprovedDate (Дата и время одобрения заявки - Статус 3), AcceptDate (Дата и время принятия/полной оплаты заявки - Статус 4) и ClosedDate (Дата и время закрытия заявки - Статус 5 или 6)

Для добавления продуктов в [`DealProducts`](#DealProducts) имеется процедура [`CALL "AddProductToDeal"();`](#AddProductToDeal). Это основной механизм добавления продуктов в сделку. (Есть неоптимизхированный моменет с удалением продуктов. Нужно вызвать DELETE в [`DealProducts`](#DealProducts) и UPDATE "Amount" в [`Deals`](#Deals) с использованием функции [`GetDealTotalSum`](#GetDealTotalSum))

Закрепление за сотрудником сделки выполняется через процедуру [`CALL "AssignDealResponsible"();`](#AssignDealResponsible). При этом по сделке обновляется статус на 2 - В обработке. Взаимодействия [`Interactions`](#Interactions) добавяются через INSERT. 

Оплата выполняется через процедуру [`CALL "RegisterPayment"();`](#RegisterPayment). Проверка на натуральное число происходит в коде CRM (можно вынести в БД). Если внесена полная оплата, то обновляем статус на 4 - Оплачен. 
