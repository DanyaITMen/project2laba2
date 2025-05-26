@import java.util.List
@import com.example.demo.model.MatchResult

@param List<MatchResult> matches

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Ель Класіко — Результати матчів</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: auto;
        }

        th, td {
            border: 1px solid #aaa;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f3f3f3;
        }
    </style>
</head>
<body>
<h1 style="text-align:center;">Результати Ель Класіко</h1>

<table>
    <thead>
    <tr>
        <th>Дата</th>
        <th>Стадіон</th>
        <th>Домашня команда</th>
        <th>Гостьова команда</th>
        <th>Рахунок</th>
    </tr>
    </thead>
    <tbody>
    @for (MatchResult match : matches)
        <tr>
            <td>${match.getMatchDate().toString()}</td>
            <td>${match.getStadium()}</td>
            <td>${match.getHomeTeam().getName()}</td>
            <td>${match.getAwayTeam().getName()}</td>
            <td>${match.getHomeScore()} : ${match.getAwayScore()}</td>
        </tr>
    @endfor
    </tbody>
</table>
</body>
</html>
