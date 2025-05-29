@import com.example.demo.model.Team
@import java.util.List

@param List<Team> teams

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Додати матч - Футбольний портал</title>
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
            flex-direction: column;
            align-items: center;
            position: relative;
            overflow: auto; /* Дозволяємо прокрутку */
            padding: 20px 0; /* Зменшуємо верхній/нижній відступ */
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

        .match-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 30px; /* Зменшено padding */
            box-shadow:
                    0 25px 50px rgba(0, 0, 0, 0.2),
                    0 0 0 1px rgba(255, 255, 255, 0.2);
            max-width: 450px; /* Зменшено ширину */
            width: 100%;
            position: relative;
            animation: slideInUp 0.8s ease-out;
            max-height: 90vh; /* Обмежуємо висоту контейнера */
            overflow-y: auto; /* Додаємо прокрутку, якщо вміст не вміщається */
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

        .match-container::before {
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
            margin-bottom: 20px; /* Зменшено відступ */
        }

        .header h2 {
            color: #2c3e50;
            font-size: 2rem; /* Зменшено розмір шрифту */
            font-weight: bold;
            margin-bottom: 8px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .header .subtitle {
            color: #7f8c8d;
            font-size: 0.9rem; /* Зменшено розмір шрифту */
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .football-icon {
            font-size: 1.2rem; /* Зменшено розмір іконки */
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-8px); }
            60% { transform: translateY(-4px); }
        }

        form {
            background: transparent;
            padding: 0;
            border-radius: 0;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px; /* Зменшено відступ між полями */
        }

        .input-group label {
            position: absolute;
            top: 12px; /* Зменшено відступ */
            left: 15px;
            color: #7f8c8d;
            transition: all 0.3s ease;
            pointer-events: none;
            font-size: 0.9rem; /* Зменшено розмір шрифту */
        }

        .input-group input,
        .input-group select {
            width: 100%;
            padding: 15px; /* Зменшено padding */
            border: 2px solid #ecf0f1;
            border-radius: 10px; /* Зменшено радіус */
            font-size: 0.9rem; /* Зменшено розмір шрифту */
            background: #fff;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1); /* Зменшено тінь */
        }

        .input-group select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 24 24"><path fill="%237f8c8d" d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 15px center;
        }

        .input-group input:focus,
        .input-group select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 3px 15px rgba(52, 152, 219, 0.3);
            transform: translateY(-1px);
        }

        .input-group input:focus + label,
        .input-group input:valid + label,
        .input-group select:focus + label,
        .input-group select:valid + label {
            top: -8px; /* Зменшено відступ */
            left: 10px;
            font-size: 0.7rem; /* Зменшено розмір шрифту */
            color: #3498db;
            background: #fff;
            padding: 0 3px;
            font-weight: bold;
        }

        .submit-btn {
            width: 100%;
            padding: 15px; /* Зменшено padding */
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem; /* Зменшено розмір шрифту */
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.3);
            position: relative;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(46, 204, 113, 0.4);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .nav-links {
            text-align: center;
            margin-top: 20px; /* Зменшено відступ */
        }

        .nav-links a {
            display: inline-block;
            padding: 12px 20px; /* Зменшено padding */
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 0.9rem; /* Зменшено розмір шрифту */
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(52, 152, 219, 0.3);
            position: relative;
            overflow: hidden;
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
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
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
            width: 40px; /* Зменшено розмір */
            height: 40px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 30%, #fff, #e0e0e0);
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            animation: float 6s ease-in-out infinite;
        }

        .floating-ball:nth-child(1) {
            top: 5%;
            left: 5%;
            animation-delay: 0s;
        }

        .floating-ball:nth-child(2) {
            top: 15%;
            right: 10%;
            animation-delay: 2s;
        }

        .floating-ball:nth-child(3) {
            bottom: 10%;
            left: 10%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
        }

        @media (max-width: 480px) {
            .match-container {
                margin: 10px;
                padding: 20px;
            }

            .header h2 {
                font-size: 1.8rem;
            }

            .input-group input,
            .input-group select {
                padding: 12px;
                font-size: 0.8rem;
            }

            .submit-btn {
                padding: 12px;
                font-size: 0.9rem;
            }

            .nav-links a {
                padding: 10px 15px;
                font-size: 0.8rem;
            }
        }

        @media (max-height: 768px) {
            .match-container {
                padding: 20px;
                max-height: 85vh; /* Ще більше обмежуємо висоту */
            }

            .header h2 {
                font-size: 1.8rem;
            }

            .header .subtitle {
                font-size: 0.8rem;
            }

            .input-group {
                margin-bottom: 15px;
            }

            .input-group input,
            .input-group select {
                padding: 12px;
                font-size: 0.8rem;
            }

            .submit-btn {
                padding: 12px;
                font-size: 0.9rem;
            }

            .nav-links {
                margin-top: 15px;
            }

            .nav-links a {
                padding: 10px 15px;
                font-size: 0.8rem;
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

<div class="match-container">
    <div class="header">
        <h2>⚽ Додати новий матч</h2>
        <div class="subtitle">
            <span class="football-icon">🏆</span>
            Футбольний портал
            <span class="football-icon">🏆</span>
        </div>
    </div>

    <form method="post" action="/matches/add">
        <div class="input-group">
            <input type="date" name="matchDate" required>
            <label>Дата</label>
        </div>

        <div class="input-group">
            <input type="text" name="stadium" required>
            <label>Стадіон</label>
        </div>

        <div class="input-group">
            <select name="homeTeamId" required>
                <option value="" disabled selected hidden></option>
                @for (Team team : teams)
                    <option value="${team.getId()}">${team.getName()}</option>
                @endfor
            </select>
            <label>Домашня команда</label>
        </div>

        <div class="input-group">
            <select name="awayTeamId" required>
                <option value="" disabled selected hidden></option>
                @for (Team team : teams)
                    <option value="${team.getId()}">${team.getName()}</option>
                @endfor
            </select>
            <label>Гостьова команда</label>
        </div>

        <div class="input-group">
            <input type="number" name="homeScore" min="0" required>
            <label>Голи домашніх</label>
        </div>

        <div class="input-group">
            <input type="number" name="awayScore" min="0" required>
            <label>Голи гостей</label>
        </div>

        <button type="submit" class="submit-btn">⭐ Додати матч</button>
    </form>

    <div class="nav-links">
        <a href="/">🏠 На головну</a>
    </div>
</div>

<script>
    // Добавляем интерактивности
    document.querySelectorAll('input, select').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
        });
    });

    // Интерактивность для ссылки
    document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('mouseover', function() {
            this.style.transform = 'scale(1.05)';
        });
        link.addEventListener('mouseout', function() {
            this.style.transform = 'scale(1)';
        });
    });

    // Анимация загрузки
    window.addEventListener('load', () => {
        document.querySelector('.match-container').style.animation = 'slideInUp 0.8s ease-out';
    });
</script>
</body>
</html>