Развернул виртуалки в соответствии с заданием

![Public Instance](Image/image.png)

![Private Instance](Image/image-1.png)

А так-же сеть и подсети (видно, что к private зацеплена таблица маршрутов)
![Network and Subnets](Image/image-2.png)

Таблица маршрутов
![Route Table](Image/image-3.png)

Пинг ya.ru с public инстанса

![Ping Test](Image/image-4.png)

почему то у меня не получается нормально подключиться к привату, видимо из за ключей на рабочем ноутбуке, хотя явно указываю ключ, через который требуется подключиться. 
Получилось только через команду:
```
ssh -o "ProxyCommand ssh -i ~/.ssh/yandex_cloud -W %h:%p shibegora@46.21.244.107" \
    -i ~/.ssh/yandex_cloud shibegora@192.168.20.20
```
![SSH Connection](Image/image-5.png)
