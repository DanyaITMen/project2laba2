<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Авторизація - Футбольний портал</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg,
            rgba(22, 160, 133, 0.9),
            rgba(46, 204, 113, 0.9),
            rgba(52, 152, 219, 0.9)
            ),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><defs><pattern id="footballPattern" x="0" y="0" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="40" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="2"/><polygon points="50,20 35,35 35,65 50,80 65,65 65,35" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100%" height="100%" fill="url(%23footballPattern)"/></svg>');
            background-size: cover;
            background-attachment: fixed;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 20% 20%, rgba(255,255,255,0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 80%, rgba(255,255,255,0.1) 0%, transparent 50%),
                    radial-gradient(circle at 40% 60%, rgba(46, 204, 113, 0.2) 0%, transparent 50%);
            animation: backgroundPulse 6s ease-in-out infinite alternate;
        }

        @keyframes backgroundPulse {
            0% { opacity: 1; }
            100% { opacity: 0.7; }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 50px;
            box-shadow:
                    0 25px 50px rgba(0, 0, 0, 0.2),
                    0 0 0 1px rgba(255, 255, 255, 0.2);
            max-width: 450px;
            width: 100%;
            position: relative;
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e74c3c, #f39c12, #f1c40f, #2ecc71, #3498db, #9b59b6);
            border-radius: 25px 25px 0 0;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h2 {
            color: #2c3e50;
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .header .subtitle {
            color: #7f8c8d;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .football-icon {
            font-size: 1.5rem;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }

        form {
            background: transparent;
            padding: 0;
            border-radius: 0;
        }

        .input-group {
            position: relative;
            margin-bottom: 30px;
        }

        .input-group label {
            position: absolute;
            top: 15px;
            left: 20px;
            color: #7f8c8d;
            transition: all 0.3s ease;
            pointer-events: none;
            font-size: 1rem;
        }

        .input-group input {
            width: 100%;
            padding: 20px;
            border: 2px solid #ecf0f1;
            border-radius: 15px;
            font-size: 1rem;
            background: #fff;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .input-group input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 5px 25px rgba(52, 152, 219, 0.3);
            transform: translateY(-2px);
        }

        .input-group input:focus + label,
        .input-group input:valid + label {
            top: -10px;
            left: 15px;
            font-size: 0.8rem;
            color: #3498db;
            background: #fff;
            padding: 0 5px;
            font-weight: bold;
        }

        .login-btn {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 25px rgba(52, 152, 219, 0.3);
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }

        .login-btn:hover::before {
            left: 100%;
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(52, 152, 219, 0.4);
        }

        .login-btn:active {
            transform: translateY(-1px);
        }

        .signup-btn {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 25px rgba(46, 204, 113, 0.3);
            text-decoration: none;
            display: block;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .signup-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }

        .signup-btn:hover::before {
            left: 100%;
        }

        .signup-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(46, 204, 113, 0.4);
        }

        .message {
            margin-top: 20px;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            font-weight: bold;
            animation: fadeIn 0.5s ease-out;
        }

        .error-message {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .logout-message {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
            box-shadow: 0 5px 15px rgba(243, 156, 18, 0.3);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
            color: #bdc3c7;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #ecf0f1;
        }

        .divider span {
            padding: 0 20px;
            font-weight: bold;
        }

        @media (max-width: 480px) {
            .login-container {
                margin: 20px;
                padding: 30px 25px;
            }

            .header h2 {
                font-size: 2rem;
            }
        }

        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }

        .floating-ball {
            position: absolute;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 30%, #fff, #e0e0e0);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            animation: float 6s ease-in-out infinite;
        }

        .floating-ball:nth-child(1) {
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-ball:nth-child(2) {
            top: 20%;
            right: 15%;
            animation-delay: 2s;
        }

        .floating-ball:nth-child(3) {
            bottom: 15%;
            left: 15%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
    </style>
</head>
<body>
<div class="floating-elements">
    <div class="floating-ball"></div>
    <div class="floating-ball"></div>
    <div class="floating-ball"></div>
</div>

<div class="login-container">
    <div class="header">
        <h2>⚽ Вхід в систему</h2>
        <div class="subtitle">
            <span class="football-icon">🏆</span>
            Футбольний портал
            <span class="football-icon">🏆</span>
        </div>
    </div>

    <form method="post" action="/login">
        <div class="input-group">
            <input type="text" name="username" required>
            <label>Ім'я користувача</label>
        </div>

        <div class="input-group">
            <input type="password" name="password" required>
            <label>Пароль</label>
        </div>

        <button type="submit" class="login-btn">
            🚀 Увійти в систему
        </button>
    </form>

    <div class="divider">
        <span>або</span>
    </div>

    <a href="/signup" class="signup-btn">
        ⭐ Зареєструватися
    </a>

    <div id="messageContainer">
        <script>
            const params = new URLSearchParams(window.location.search);
            if (params.has('error')) {
                document.getElementById('messageContainer').innerHTML =
                    '<div class="message error-message">❌ Невірний логін або пароль!</div>';
            }
            if (params.has('logout')) {
                document.getElementById('messageContainer').innerHTML =
                    '<div class="message logout-message">👋 Ви вийшли з системи.</div>';
            }
        </script>
    </div>
</div>

<script>
    // Добавляем интерактивности
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
        });
    });

    // Анимация загрузки
    window.addEventListener('load', () => {
        document.querySelector('.login-container').style.animation = 'slideInUp 0.8s ease-out';
    });
</script>
</body>
</html>