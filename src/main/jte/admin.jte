<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Адмін-панель - Футбольний портал</title>
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

        .admin-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 50px;
            box-shadow:
                    0 25px 50px rgba(0, 0, 0, 0.2),
                    0 0 0 1px rgba(255, 255, 255, 0.2);
            max-width: 600px;
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

        .admin-container::before {
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

        p {
            color: #34495e;
            font-size: 1.1rem;
            text-align: center;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .nav-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .nav-links a {
            display: inline-block;
            padding: 15px 25px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            text-decoration: none;
            border-radius: 15px;
            font-size: 1rem;
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
            position: relative;
            overflow: hidden;
        }

        .nav-links a.logout {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .nav-links a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }

        .nav-links a:hover::before {
            left: 100%;
        }

        .nav-links a:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(52, 152, 219, 0.4);
        }

        .nav-links a.logout:hover {
            box-shadow: 0 10px 25px rgba(231, 76, 60, 0.4);
        }

        .nav-links a:active {
            transform: translateY(-1px);
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

        @media (max-width: 480px) {
            .admin-container {
                margin: 20px;
                padding: 30px 25px;
            }

            .header h2 {
                font-size: 2rem;
            }

            .nav-links {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
<div class="floating-elements">
    <div class="floating-ball"></div>
    <div class="floating-ball"></div>
    <div class="floating-ball"></div>
</div>

<div class="admin-container">
    <div class="header">
        <h2>⚽ Адмін-панель</h2>
        <div class="subtitle">
            <span class="football-icon">🏆</span>
            Футбольний портал
            <span class="football-icon">🏆</span>
        </div>
    </div>

    <p>Тут ви можете керувати даними (додати, видалити, редагувати і т.д.).</p>

    <div class="nav-links">
        <a href="/matches/add">⭐ Додати матч</a>
        <a href="/matches/edit/1">✏️ Редагувати матч</a>
        <a href="/matches/delete">❌ Видалити матч</a>
        <a href="/">🏠 На головну</a>
        <a href="/logout" class="logout">🚪 Вийти</a>
    </div>
</div>

<script>
    // Анимация загрузки
    window.addEventListener('load', () => {
        document.querySelector('.admin-container').style.animation = 'slideInUp 0.8s ease-out';
    });

    // Интерактивность для ссылок
    document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('mouseover', function() {
            this.style.transform = 'scale(1.05)';
        });
        link.addEventListener('mouseout', function() {
            this.style.transform = 'scale(1)';
        });
    });
</script>
</body>
</html>