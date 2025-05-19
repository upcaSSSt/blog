# blog

Версия ruby<br>
ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]

Версия rails<br>
Rails 7.1.5.1

База данных - mysql<br>
Чтобы решить возможную проблему с правами доступа к базе
```
sudo mysql -u root --skip-password
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pass';
rake db:create
rake db:migrate
```
<hr>

+ Пост - картинка + текст.
+ Для добавлений поста нужно быть зарегистрированным
+ Каждый зарегистрированный пользователь может подписываться на посты других пользователей.
+ Посты можно искать с использованием текстового запроса.
+ Комментарии

Есть 2 аккаунта<br>
Логины: azabej02@gmail.com, pjotrpjetya@gmail.com<br>
Пароль для 2 аккаунтов: 123456

Сначала лучше зайти на azabej02@gmail.com. azabej02@gmail.com подписан на pjotrpjetya@gmail.com, поэтому в корне будут его посты, а также поле поиска и кнопка создания поста. Кликнув по тексту поста можно перейти на страницу с комментариями и редактированием.<br>
Чтобы подписаться или отписаться от человека, кликаем внизу на "Люди" и выбираем нужный профиль. В профиле есть кнопка для подписки.

### API
```
GET
http://localhost:3000/api/v1/posts - все посты
http://localhost:3000/api/v1/posts/1 - конкретный пост
http://localhost:3000/api/v1/users - все пользователи
http://localhost:3000/api/v1/users/1 - конкретный пользователь
```
```
POST
http://localhost:3000/api/v1/users/1/posts {"body": "..."} - создать пост от пользователя
http://localhost:3000/api/v1/users/1/posts/1/comments {"body": "..."} - создать комментарий от пользователя к посту
```
```
PUT
http://localhost:3000/api/v1/posts/1 {"body": "..."} - редактировать пост
```
```
DELETE
http://localhost:3000/api/v1/posts/1 - удалить пост
http://localhost:3000/api/v1/purge_image/1 - удалить картинку
```
### Docker
https://hub.docker.com/repository/docker/upcast006/blog-app
```
sudo docker compose build
sudo docker compose up -d
docker exec -it blog-app
rails db:migrate
```
