@import java.util.List
@import com.example.demo.model.MatchResult

@param List<MatchResult> matches

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ель Класіко — Результати матчів</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg,
            rgba(22, 160, 133, 0.9),
            rgba(46, 204, 113, 0.9),
            rgba(52, 152, 219, 0.9)
            ),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><defs><pattern id="footballPattern" x="0" y="0" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="40" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="2"/><polygon points="50,20 35,35 35,65 50,80 65,65 65,35" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100%" height="100%" fill="url(%23footballPattern)"/></svg>');
            background-size: cover;
            background-attachment: fixed;
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
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
            pointer-events: none;
        }

        @keyframes backgroundPulse {
            0% { opacity: 1; }
            100% { opacity: 0.7; }
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            animation: fadeInDown 1s ease-out;
        }

        .header h1 {
            font-size: 3.5rem;
            color: white;
            margin-bottom: 15px;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
        }

        .header .subtitle {
            color: rgba(255,255,255,0.9);
            font-size: 1.3rem;
            font-weight: bold;
        }

        .football-icon {
            font-size: 3rem;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-15px); }
            60% { transform: translateY(-8px); }
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 30px;
            box-shadow:
                    0 25px 50px rgba(0, 0, 0, 0.2),
                    0 0 0 1px rgba(255, 255, 255, 0.2);
            animation: slideInUp 0.8s ease-out 0.3s both;
            position: relative;
            overflow: hidden;
        }

        .table-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, #e74c3c, #f39c12, #f1c40f, #2ecc71, #3498db, #9b59b6);
            border-radius: 25px 25px 0 0;
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

        table {
            border-collapse: collapse;
            width: 100%;
            margin: auto;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            animation: tableSlideIn 1s ease-out 0.6s both;
        }

        @keyframes tableSlideIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        th, td {
            border: none;
            padding: 18px 15px;
            text-align: center;
            position: relative;
            transition: all 0.3s ease;
        }

        th {
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            font-weight: bold;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            position: relative;
        }

        th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #3498db, #2ecc71, #f39c12);
        }

        tbody tr {
            transition: all 0.3s ease;
            animation: rowFadeIn 0.6s ease-out forwards;
            opacity: 0;
        }

        tbody tr:nth-child(1) { animation-delay: 0.8s; }
        tbody tr:nth-child(2) { animation-delay: 0.9s; }
        tbody tr:nth-child(3) { animation-delay: 1.0s; }
        tbody tr:nth-child(4) { animation-delay: 1.1s; }
        tbody tr:nth-child(5) { animation-delay: 1.2s; }
        tbody tr:nth-child(n+6) { animation-delay: 1.3s; }

        @keyframes rowFadeIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        tbody tr:hover {
            background: linear-gradient(135deg, #ecf0f1, #bdc3c7);
            transform: scale(1.02);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            z-index: 10;
        }

        tbody tr:nth-child(even) {
            background: #f8f9fa;
        }

        tbody tr:nth-child(odd) {
            background: white;
        }

        td {
            font-size: 1rem;
            color: #2c3e50;
            font-weight: 500;
        }

        td:first-child {
            font-weight: bold;
            color: #3498db;
        }

        td:nth-child(3), td:nth-child(4) {
            font-weight: bold;
            font-size: 1.1rem;
        }

        td:nth-child(3) {
            color: #00529F;
        }

        td:nth-child(4) {
            color: #A50044;
        }

        td:last-child {
            font-weight: bold;
            font-size: 1.2rem;
            color: #27ae60;
            background: linear-gradient(135deg, #d5f4e6, #a8e6cf);
            border-radius: 10px;
            margin: 5px;
            box-shadow: inset 0 2px 5px rgba(0,0,0,0.1);
        }

        .stadium-cell {
            position: relative;
        }

        .stadium-cell::before {
            content: '🏟️';
            margin-right: 8px;
        }

        .date-cell {
            position: relative;
        }

        .date-cell::before {
            content: '📅';
            margin-right: 8px;
        }

        .btn-delete {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(231, 76, 60, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(231, 76, 60, 0.4);
            background: linear-gradient(135deg, #c0392b, #a93226);
        }

        .btn-delete:active {
            transform: translateY(0);
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.5rem;
                flex-direction: column;
                gap: 10px;
            }

            .table-container {
                padding: 15px;
                margin: 0 10px;
            }

            table {
                font-size: 0.9rem;
            }

            th, td {
                padding: 12px 8px;
            }

            th {
                font-size: 0.9rem;
            }

            .btn-delete {
                padding: 6px 12px;
                font-size: 0.8rem;
            }
        }

        @media (max-width: 480px) {
            .header h1 {
                font-size: 2rem;
            }

            table {
                font-size: 0.8rem;
            }

            th, td {
                padding: 8px 5px;
            }

            .btn-delete {
                padding: 5px 10px;
                font-size: 0.7rem;
            }
        }

        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
            z-index: 0;
        }

        .floating-ball {
            position: absolute;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 30%, rgba(255,255,255,0.8), rgba(224,224,224,0.6));
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            animation: float 8s ease-in-out infinite;
        }

        .floating-ball:nth-child(1) {
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-ball:nth-child(2) {
            top: 60%;
            right: 15%;
            animation-delay: 3s;
        }

        .floating-ball:nth-child(3) {
            bottom: 20%;
            left: 20%;
            animation-delay: 6s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.7;
            }
            50% {
                transform: translateY(-30px) rotate(180deg);
                opacity: 1;
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

<div class="container">
    <div class="header">
        <h1>
            <span class="football-icon">⚽</span>
            Результати Ель Класіко
            <span class="football-icon">⚽</span>
        </h1>
        <div class="subtitle">🏆 Найкращі матчі світового футболу 🏆</div>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>📅 Дата</th>
                <th>🏟️ Стадіон</th>
                <th>🏠 Домашня команда</th>
                <th>✈️ Гостьова команда</th>
                <th>⚽ Рахунок</th>
                <th>Дії</th>
            </tr>
            </thead>
            <tbody>
            @for (MatchResult match : matches)
                <tr>
                    <td class="date-cell">${match.getMatchDate().format(java.time.format.DateTimeFormatter.ofPattern("dd.MM.yyyy"))}</td>
                    <td class="stadium-cell">${match.getStadium()}</td>
                    <td>${match.getHomeTeam().getName()}</td>
                    <td>${match.getAwayTeam().getName()}</td>
                    <td>${match.getHomeScore()} : ${match.getAwayScore()}</td>
                    <td>
                        <form method="post" action="/matches/delete" onsubmit="return confirm('Ви впевнені, що хочете видалити цей матч?');">
                            <input type="hidden" name="id" value="${match.getId()}">
                            <button class="btn-delete" type="submit">Видалити</button>
                        </form>
                    </td>
                </tr>
            @endfor
            </tbody>
        </table>
    </div>
</div>

<script>
    // Добавляем интерактивности для строк таблицы
    document.querySelectorAll('tbody tr').forEach((row, index) => {
        row.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.02) translateZ(10px)';
        });

        row.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1) translateZ(0px)';
        });
    });
</script>
</body>
</html>