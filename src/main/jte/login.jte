<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Авторизація</title>
    <style>
        body {
            font-family: Arial;
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
        }
        form {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 5px;
        }
        input, button {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 8px;
        }
    </style>
</head>
<body>

<h2>Вхід в систему</h2>

<form method="post" action="/login">
    <label>Ім'я користувача:</label>
    <input type="text" name="username" required>

    <label>Пароль:</label>
    <input type="password" name="password" required>

    <button type="submit">Увійти</button>
</form>

<!-- Повідомлення -->
<div style="color: red; margin-top: 10px;">
    <script>
        const params = new URLSearchParams(window.location.search);
        if (params.has('error')) {
            document.write("Невірний логін або пароль!");
        }
        if (params.has('logout')) {
            document.write("Ви вийшли з системи.");
        }
    </script>
</div>

</body>
</html>
