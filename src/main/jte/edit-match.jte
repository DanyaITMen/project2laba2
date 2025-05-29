@import java.util.List
@import com.example.demo.model.MatchResult
@import com.example.demo.model.Team

@param MatchResult match
@param List<Team> teams

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Редагувати матч - Футбольний портал</title>
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
            overflow: auto;
            padding: 20px 0;
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

        .edit-match-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(255, 255, 255, 0.2);
            max-width: 600px;
            width: 100%;
            position: relative;
            animation: slideInUp 0.8s ease-out;
            max-height: 90vh;
            overflow-y: auto;
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

        .edit-match-container::before {
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
            margin-bottom: 20px;
        }

        .header h2 {
            color: #2c3e50;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 8px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header .subtitle {
            color: #7f8c8d;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .football-icon {
            font-size: 1.2rem;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-8px); }
            60% { transform: translateY(-4px); }
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group label {
            position: absolute;
            top: 12px;
            left: 15px;
            color: #7f8c8d;
            transition: all 0.3s ease;
            pointer-events: none;
            font-size: 0.9rem;
        }

        .input-group input,
        .input-group select {
            width: 100%;
            padding: 15px;
            border: 2px solid #ecf0f1;
            border-radius: 10px;
            font-size: 0.9rem;
            background: #fff;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
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
            top: -8px;
            left: 10px;
            font-size: 0.7rem;
            color: #3498db;
            background: #fff;
            padding: 0 3px;
            font-weight: bold;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
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
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
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

        .nav-buttons {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .nav-buttons a {
            text-decoration: none;
            flex: 1;
        }

        .nav-buttons button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
            position: relative;
            overflow: hidden;
        }

        .nav-buttons button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.5s;
        }

        .nav-buttons button:hover::before {
            left: 100%;
        }

        .nav-buttons button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(52, 152, 219, 0.4);
        }

        .nav-buttons button:active {
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
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 30%, #fff, #e0e0e0);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
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
            .edit-match-container {
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

            .submit-btn,
            .nav-buttons button {
                padding: 12px;
                font-size: 0.9rem;
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

<div class="edit-match-container">
    <div class="header">
        <h2>⚽ Редагувати матч</h2>
        <div class="subtitle">
            <span class="football-icon">🏆</span>
            Футбольний портал
            <span class="football-icon">🏆</span>
        </div>
    </div>

    <form method="post" action="/matches/update">
        <input type="hidden" name="id" value="${match.getId()}">

        <div class="input-group">
            <input type="text" name="stadium" value="${match.getStadium()}" required>
            <label>Стадіон</label>
        </div>

        <div class="input-group">
            <input type="date" name="matchDate" value="${match.getMatchDate().toString()}" required>
            <label>Дата матчу</label>
        </div>

        <div class="input-group">
            <select name="homeTeamId" required>
                @for (Team homeTeam : teams) {
                    @if (homeTeam.getId().equals(match.getHomeTeam().getId())) {
                        <option value="${homeTeam.getId()}" selected>${homeTeam.getName()}</option>
                        } else {
                        <option value="${homeTeam.getId()}">${homeTeam.getName()}</option>
                        }
                    @endif
                    }
                @endfor
            </select>
            <label>Домашня команда</label>
        </div>

        <div class="input-group">
            <select name="awayTeamId" required>
                @for (Team awayTeam : teams) {
                    @if (awayTeam.getId().equals(match.getAwayTeam().getId())) {
                        <option value="${awayTeam.getId()}" selected>${awayTeam.getName()}</option>
                        } else {
                        <option value="${awayTeam.getId()}">${awayTeam.getName()}</option>
                        }
                    @endif
                    }
                @endfor
            </select>
            <label>Гостьова команда</label>
        </div>

        <div class="input-group">
            <input type="number" name="homeScore" value="${match.getHomeScore()}" min="0" required>
            <label>Голи домашньої команди</label>
        </div>

        <div class="input-group">
            <input type="number" name="awayScore" value="${match.getAwayScore()}" min="0" required>
            <label>Голи гостьової команди</label>
        </div>

        <button type="submit" class="submit-btn">💾 Зберегти зміни</button>
    </form>

    <!-- Кнопки навігації -->
    <div class="nav-buttons">
        <a href="/matches/edit/${match.getId() - 1}">
            <button type="button">← Попередній матч</button>
        </a>
        <a href="/matches/edit/${match.getId() + 1}">
            <button type="button">Наступний матч →</button>
        </a>
    </div>
</div>

<script>
    // Анімація завантаження
    window.addEventListener('load', () => {
        document.querySelector('.edit-match-container').style.animation = 'slideInUp 0.8s ease-out';
    });

    // Інтерактивність для полів
    document.querySelectorAll('input, select').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
        });
        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
        });
    });

    // Інтерактивність для кнопок
    document.querySelectorAll('.nav-buttons button').forEach(button => {
        button.addEventListener('mouseover', function() {
            this.style.transform = 'scale(1.05)';
        });
        button.addEventListener('mouseout', function() {
            this.style.transform = 'scale(1)';
        });
    });
</script>
</body>
</html>