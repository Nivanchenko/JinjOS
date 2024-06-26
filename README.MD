## JinjOS

Библиотека - шаблонизатор, вдохновленная шаблонизаторм Jinja2. 

JinjOS предназначен для удобной генерации текста. Например сообщений в телеграмме, html страниц, или почтовых сообщений.

Внутри шаблона можно подставлять любые выражения, возвращающие значения. А так же использовать любые языковые конструкции.

Значения подставляются конструкций вида `{{Значение_или_Функция()}}`

Например:

Передача контекста в шаблон

```bsl
ТекстШаблона = "Привет {{Контекст.Имя}}";
Шаблон = Новый Шаблон(ТекстШаблона);
Сообщить(Шаблон.СформироватьТекст(Новый Структура("Имя", "Никита")));
```

Данный код выведет на экран `Привет Никита`

Вызов методов внутри шаблона

```bsl
ТекстШаблона = "Текущее время {{ТекущаяДата()}}";
Шаблон = Новый Шаблон(ТекстШаблона);
Сообщить(Шаблон.СформироватьТекст());
```

Текущий код выведет на экран `Текущее время 28.03.2024 19:42:59`

Вычисление выражений внутри шаблона

```bsl
ТекстШаблона = "2 + 2 = {{ 2 + 2 }}";
Шаблон = Новый Шаблон(ТекстШаблона);
Сообщить(Шаблон.СформироватьТекст());
```

Текущий код выведет на экран `2 + 2 = 4`

В роли контекста может быть любой объект OneScript.

А так же внутри шаблона можно использовать любые языковые конструкции OneScript. Исполняемый код заключается в `{%... %}`. Возможно объявление переменных, циклов, условий.

Например:

Объявление переменных внутри шаблона

```bsl
ТекстШаблона = "{% ПеременнаяВнутриШаблона = 10;
                |  ЕщеПеременная = 1; %}
                |Привет некоторый текст
                |{{ПеременнаяВнутриШаблона}} и {{ЕщеПеременная}}";
Шаблон = Новый Шаблон(ТекстШаблона);
Сообщить(Шаблон.СформироватьТекст());
```

Текущий код выведет на экран 

```
Привет некоторый текст 
10 и 1
```

Использование условий внутри шаблона

```bsl
ТекстШаблона = "{% Если Контекст > 5 Тогда %}
                |Контекст {{Контекст}} больше 5
                |{% Иначе %}
                |Контекст {{Контекст}} меньше 5
                |{% КонецЕсли; %}";
Шаблон = Новый Шаблон(ТекстШаблона);
Сообщить(Шаблон.СформироватьТекст(3));
```

Текущий код выведет на экран `Контекст 3 меньше 5`

Использование циклов внутри шаблона

```bsl
ТекстШаблона = "{% Для Каждого Элемент Из Контекст Цикл %}
                |Элемент {{Элемент}}
                |{% КонецЦикла; %}";
Шаблон = Новый Шаблон(ТекстШаблона);
Массив = Новый Массив;
Массив.Добавить(1);
Массив.Добавить(2);
Массив.Добавить(3);
Сообщить(Шаблон.СформироватьТекст(Массив));
```

Текущий код выведет на экран 

```
Элемент 1

Элемент 2

Элемент 3
```

Вывод вложенных шаблонов, для этого внутри шаблона доступен метод `ВывестиПоШаблону(Шаблон, Контекст)`

```bsl
ТекстШаблона =  " Привет {{ ВывестиПоШаблону(Контекст.Шаблон, Контекст) }}";
Шаблон = Новый Шаблон(ТекстШаблона);
Контекст = Новый Структура("Шаблон, Переменная", "{{Контекст.Переменная}}", "Никита");
Сообщить(Шаблон.СформироватьТекст(Контекст));
```

Текущий код выведет на экран `Привет Никита`, так как внутри шаблона `{{Контекст.Переменная}}` будет вычислено значение `Никита`.

Некоторые ограничения.

Не поддерживается передача в текст исполняемого кода значений из текста шаблона.

Например:

```bsl
ТекстШаблона = "{% Если Контекст > %} 5 {% Тогда %}
                |Контекст {{Контекст}} больше 5
                |{% Иначе %}
                |Контекст {{Контекст}} меньше 5
                |{% КонецЕсли; %}";
Шаблон = Новый Шаблон(ТекстШаблона);
Сообщить(Шаблон.СформироватьТекст(3));
```

Как мы видим, я попытался передать в условие значение 5. Это не поддерживается.
