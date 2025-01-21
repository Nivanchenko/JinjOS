#Использовать ".."
#Использовать asserts


&Тест
Процедура ПодставляетсяКонтекст() Экспорт
	// Дано
	Шаблон = Новый Шаблон("1{{Контекст.Переменная}}3");
	Контекст = Новый Структура("Переменная", 2);

	// Когда
	Результат = Шаблон.СформироватьТекст(Контекст);

	// Тогда
    Ожидаем.Что(Результат).Равно("123");

КонецПроцедуры

&Тест
Процедура УсловиеВШаблоне() Экспорт
	// Дано

	ТекстШаблона = "{% Если Контекст.Переменная = 2 Тогда 
	|					%}1{%
	|				 Иначе 
	|					%}3{%
	|				КонецЕсли; %}";

	Шаблон = Новый Шаблон(ТекстШаблона);

	Контекст = Новый Структура("Переменная", 2);

	// Когда

	Результат1 = Шаблон.СформироватьТекст(Контекст);
	Контекст.Переменная = 3;

	Результат2 = Шаблон.СформироватьТекст(Контекст);

	// Тогда

	Ожидаем.Что(Результат1).Равно("1");
	Ожидаем.Что(Результат2).Равно("3");
	
КонецПроцедуры

&Тест
Процедура ЦиклВШаблоне() Экспорт

	// Дано
	ТекстШаблона = "{% Для Каждого Элемент Из Контекст.Массив Цикл %}{{Элемент}}{% КонецЦикла; %}";
	Шаблон = Новый Шаблон(ТекстШаблона);
	Контекст = Новый Структура("Массив", Новый Массив);
	Контекст.Массив.Добавить(1);
	Контекст.Массив.Добавить(2);
	Контекст.Массив.Добавить(3);

	// Когда
	Результат = Шаблон.СформироватьТекст(Контекст);

	// Тогда
	Ожидаем.Что(Результат).Равно("123");

КонецПроцедуры

&Тест
Процедура ВложенныйШаблон() Экспорт
	// Дано
	ТекстШаблона =  "1{{ВывестиПоШаблону(Контекст.Шаблон, Контекст)}}";
	Шаблон = Новый Шаблон(ТекстШаблона);
	Контекст = Новый Структура("Шаблон, Переменная", "{{Контекст.Переменная}}", 2);

	// Когда
	Результат = Шаблон.СформироватьТекст(Контекст);

	// Тогда
	Ожидаем.Что(Результат).Равно("12");

КонецПроцедуры

&Тест
Процедура ВнутреннийКонтекстШаблона() Экспорт
	// Дано
	ТекстШаблона = "{% ВнутренняяПеременная = 1; %}1{{ВнутренняяПеременная + Контекст.Переменная}}";
	Шаблон = Новый Шаблон(ТекстШаблона);
	Контекст = Новый Структура("Переменная", 1);

	// Когда
	Результат = Шаблон.СформироватьТекст(Контекст);

	// Тогда
	Ожидаем.Что(Результат).Равно("12");

КонецПроцедуры

&Тест
Процедура ОбратнаяСовместимостьМодель()	Экспорт
	// Дано
	ТекстШаблона = "1{{Модель.Переменная}}3";
	Шаблон = Новый Шаблон(ТекстШаблона);
	Контекст = Новый Структура("Переменная", 2);

	// Когда
	Результат = Шаблон.СформироватьТекст(Контекст);

	// Тогда
	Ожидаем.Что(Результат).Равно("123");

КонецПроцедуры

&Тест
Процедура ШаблонБезКонтекста() Экспорт
	// Дано
	ТекстШаблона = "1{{1+1}}3";
	Шаблон = Новый Шаблон(ТекстШаблона);

	// Когда
	Результат = Шаблон.СформироватьТекст();

	// Тогда
	Ожидаем.Что(Результат).Равно("123");

КонецПроцедуры

&Тест
Процедура ШаблонНачинаетсяСШаблона() Экспорт
	// Дано
	Шаблон = Новый Шаблон("{{1}}2{{3}}4");

	// Когда
	Результат = Шаблон.СформироватьТекст();

	// Тогда
    Ожидаем.Что(Результат).Равно("1234");

КонецПроцедуры

&Тест
Процедура ШаблонНачинаетсяСТекста() Экспорт
	// Дано
	Шаблон = Новый Шаблон("1{{2}}3{{4}}");

	// Когда
	Результат = Шаблон.СформироватьТекст();

	// Тогда
    Ожидаем.Что(Результат).Равно("1234");

КонецПроцедуры

&Тест
Процедура ПереиспользованиеШаблона() Экспорт
	// Дано
	Шаблон = Новый Шаблон("1{{Контекст.Переменная}}3");

	Контекст = Новый Структура("Переменная", 2);
	Контекст2 = Новый Структура("Переменная", 5);

	// Когда
	Результат1 = Шаблон.СформироватьТекст(Контекст);
	Результат2 = Шаблон.СформироватьТекст(Контекст2);

	// Тогда
    Ожидаем.Что(Результат1).Равно("123");

	Ожидаем.Что(Результат2).Равно("153");

КонецПроцедуры