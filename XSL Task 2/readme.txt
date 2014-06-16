Задание 2. Обработка данных.

1)Все значения по умолчанию. Прямая сортировка по исполнителю.
xsltproc --output cd.html cd.xsl cd.xml

2) Обратная сортировка по году 
xsltproc --output cd.html --stringparam sort "year" --stringparam order "descending" cd.xsl cd.xml

3)Фильтр по году и исполнителю. Обратная сортировка по году
xsltproc --output cd.html --stringparam sort "year" --stringparam order "descending" --stringparam year "1998" --stringparam artist "Eros Ramazzotti" cd.xsl cd.xml

Результат: cd.html