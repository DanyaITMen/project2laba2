<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Реєстрація</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
        }
        form {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 5px;
        }
        label {
            display: block;
            margin: 10px 0 5px 0;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        button {
            background: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .error {
            color: red;
            background: #ffe6e6;
            padding: 10px;
            border-radius: 3px;
            margin-bottom: 10px;
        }
        .success {
            color: green;
            background: #e6ffe6;
            padding: 10px;
            border-radius: 3px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<h2>Реєстрація користувача</h2>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    const success = urlParams.get('success');

    if (error) {
        document.write('<div class="error">' + decodeURIComponent(error) + '</div>');
    }
    if (success) {
        document.write('<div class="success">' + decodeURIComponent(success) + '</div>');
    }
</script>

<form method="post" action="/api/signup">
    <label>Ім'я користувача:</label>
    <input type="text" name="username" required minlength="3" maxlength="50">

    <label>Пароль:</label>
    <input type="password" name="password" required minlength="6">

    <label>Роль:</label>
    <select name="role" style="width: 100%; padding: 8px;">
        <option value="USER">Користувач</option>
        <option value="ADMIN">Адміністратор</option>
    </select>

    <br><br>
    <button type="submit">Зареєструватися</button>
</form>
</body>
</html>