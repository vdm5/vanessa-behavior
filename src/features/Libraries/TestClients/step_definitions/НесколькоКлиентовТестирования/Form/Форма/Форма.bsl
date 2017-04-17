﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;

&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;
	
	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестирования(ИмяКлиентаТестирования)","ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестирования","И Я подключаю клиент тестирования ""ИмяКлиентаТестирования"" из таблицы клиентов тестирования",, "Подключение TestClient.Работа с подключенными TestClient");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестированияОтИмениСПаролем(ИмяКлиентаТестирования,Логин,Пароль)","ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестированияОтИмениСПаролем","Когда Я подключаю клиент тестирования ""ИмяКлиентаТестирования"" из таблицы клиентов тестирования от имени ""Логин"" с паролем ""Пароль""",, "Подключение TestClient.Работа с подключенными TestClient");
	
	Возврат ВсеТесты;
КонецФункции

&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции

&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры

///////////////////////////////////////////////////

///////////////////////////////////////////////////

&НаКлиенте
//И Я подключаю клиент тестирования "ИмяКлиентаТестирования" из таблицы клиентов тестирования
//@ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестирования(ИмяКлиентаТестирования)
Процедура ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестирования(ИмяКлиентаТестирования) Экспорт

	Если ИмяКлиентаТестирования = "" Тогда
		ИмяКлиентаТестирования = "Этот клиент";
	КонецЕсли;
	
	ПодключитьTestClientИзТаблицыКлиентовТестирования(ИмяКлиентаТестирования);
	//Если НЕ ПодключитьTestClientИзТаблицыКлиентовТестирования(ИмяКлиентаТестирования) Тогда
	//	ВызватьИсключение "Не смог подключить TestClient!";
	//КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПодключитьTestClientИзТаблицыКлиентовТестирования(ИмяTestClient, Знач Логин = "", Знач Пароль = "")

	ДопПараметры = "";
	Если ЗначениеЗаполнено(Логин) Тогда
		ДопПараметры = ДопПараметры + "/N""" + Логин + """ ";
	КонецЕсли;
	Если ЗначениеЗаполнено(Пароль) Тогда
		ДопПараметры = ДопПараметры + "/P""" + Пароль + """ ";
	КонецЕсли;
	
	ЕстьПодключение = Ванесса.ПолучитьКлиентаТестирования(ИмяTestClient, ДопПараметры);
	Если Не ЕстьПодключение Тогда
		ВызватьИсключение "Не удалось подключить клиент тестирования.";
	КонецЕсли;
	
	Возврат Истина;

КонецФункции

&НаКлиенте
Процедура УдалитьЭлементПодключенныеTestClient(ПодключенныеTestClient,ИмяTestClient)
	Для Ккк = 0 По ПодключенныеTestClient.Количество()-1 Цикл
		Если ПодключенныеTestClient[Ккк].Имя = ИмяTestClient Тогда
			ПодключенныеTestClient.Удалить(Ккк);
			Прервать;
		КонецЕсли;	 
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
//Когда Я подключаю клиент тестирования "ИмяКлиентаТестирования" из таблицы клиентов тестирования от имени "Логин" с паролем "Пароль"
//@ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестированияОтИмениСПаролем(ИмяКлиентаТестирования,Логин,Пароль)
Процедура ЯПодключаюКлиентТестированияИзТаблицыКлиентовТестированияОтИмениСПаролем(ИмяКлиентаТестирования, Знач Логин = "", Знач Пароль = "") Экспорт
	
	Если Не ЗначениеЗаполнено(ИмяКлиентаТестирования) Тогда
		ИмяКлиентаТестирования = "Этот клиент";
	КонецЕсли;
	
	//СтрокаАутентификации = "";
	Логин = СокрЛП(Логин);
	Пароль = СокрЛП(Пароль);
	//ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");
	
	//Если Не ПустаяСтрока(Логин) Тогда
	//	СтрокаАутентификации = "/N" + Логин;
	//	Если Найти(Логин, " ") > 0 Тогда
	//		СтрокаАутентификации = "/N""" + СокрЛП(Логин) + """";
	//	КонецЕсли;
	//	
	//	Если Не ПустаяСтрока(Пароль) Тогда
	//		СтрокаАутентификации = СтрокаАутентификации + " /P"+Пароль;
	//	КонецЕсли;
	//КонецЕсли;
	
	Если НЕ ПодключитьTestClientИзТаблицыКлиентовТестирования(ИмяКлиентаТестирования, Логин, Пароль) Тогда
		ВызватьИсключение "Не смог подключить TestClient!";
	КонецЕсли;
	
КонецПроцедуры

//окончание текста модуля