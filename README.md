# CRM-система для малого бизнеса

## Описание проекта

Проект представляет собой базу данных для CRM-системы, разработанную на PostgreSQL. Система позволяет управлять клиентами, сделками, взаимодействиями, продуктами и платежами.

## Структура базы данных

### Таблицы (14 шт.)

| Таблица | Назначение |
|---------|------------|
| `ClientType` | Типы клиентов (физ.лицо, ИП, юр.лицо и т.д.) |
| `Companies` | Компании клиентов |
| `Clients` | Основная информация о клиентах |
| `ContactInfoType` | Типы контактной информации |
| `ClientContactInfo` | Контактная информация клиентов |
| `UserRoles` | Роли сотрудников |
| `Users` | Информация о сотрудниках |
| `DealStatuses` | Статусы заявок |
| `Deals` | Основная информация о заявках |
| `DealsHistory` | История изменения статусов |
| `InteractionTypes` | Типы взаимодействий с клиентами |
| `Interactions` | История взаимодействий |
| `Products` | Продукты и услуги |
| `DealProducts` | Связь заявок с продуктами |
| `Payments` | Информация об оплатах |

### ER-диаграмма

[ProjectCRM.erd](https://github.com/webpastillus/OtusProject/blob/main/ProjectCRM.erd) 

[ProjectCRM.erd](https://github.com/webpastillus/OtusProject/blob/main/ProjectCRM.erd) 
