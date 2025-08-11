Развернул виртуалки в соответствии с заданием
![alt text](image.png)

![alt text](image-1.png)

А так-же сеть и подсети (видно, что к private зацеплена таблица маршрутов)
![alt text](image-2.png)

Таблица маршрутов
![alt text](image-3.png)

Пинг ya.ru с public инстанса
![alt text](image-4.png)

почему то у меня не получается нормально подключиться к привату, видимо из за ключей на рабочем ноутбуке, хотя явно указываю ключ, через который требуется подключиться. 
Получилось только через команду:
```
ssh -o "ProxyCommand ssh -i ~/.ssh/yandex_cloud -W %h:%p shibegora@46.21.244.107" \
    -i ~/.ssh/yandex_cloud shibegora@192.168.20.20
```
![alt text](image-5.png)