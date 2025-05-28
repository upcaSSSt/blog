# blog

Версия ruby<br>
ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]

Версия rails<br>
Rails 7.1.5.1

База данных - mysql<br>
Чтобы решить возможную проблему с правами доступа к базе
```
mysql -u root -p
пароль: pass (или ваш пароль)
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pass';
rails db:create
rails db:migrate
```
<hr>

+ Пост - картинка + текст.
+ Для добавлений поста нужно быть зарегистрированным
+ Каждый зарегистрированный пользователь может подписываться на посты других пользователей.
+ Посты можно искать с использованием текстового запроса.
+ Комментарии

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
