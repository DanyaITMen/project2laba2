<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <style>
        body {
        }
        form {
            padding: 20px;
        }
            display: block;
            width: 100%;
        }
    </style>
</head>
<body>


    <form method="post" action="/login">
            <input type="text" name="username" required>

            <input type="password" name="password" required>

    </form>

        <script>
            const params = new URLSearchParams(window.location.search);
            if (params.has('error')) {
            }
            if (params.has('logout')) {
            }
        </script>
    </div>

</body>
</html>