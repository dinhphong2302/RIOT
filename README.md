# League of Legends Mid-Lane Player Behavior Analysis & Champion Role Recommendation

This project analyzes how high-elo mid-lane players on the NA server actually play. It then uses that behavior to recommend the champion role that best fits a player's style.

## Data

- **Source:** Riot API (`sandbox.ipynb`). The notebook pulls the Challenger, Grandmaster and Master ladders, then match details for the top 600 and the next 1,000 mid-lane players (`top600_mid_players.csv`, `next1000_mid_players.csv`).
- **Cleaning:** removes games with `timePlayed = 0` and rows with missing values. The final dataset has **1,376 player-games**.
- **Feature engineering:** per-minute normalization (gold per minute and damage to champions per minute), plus 9 other behavioral stats: vision score, wards placed and killed, kills, deaths, lane and jungle CS, longest time alive, and damage taken.
- **Role labeling in SQL (`Riot_Update_Data.sql`, SQL Server):** adds a `championRole` column and maps every champion to Assassin, Mage–Mid, Mage–Support, Fighter, Marksman or Tank with `CASE WHEN`.

## Analysis

- **EDA by role (`statistic.ipynb`):** mean, median and standard deviation of each stat per role, plus a correlation heatmap. For example, mid-lane mages average about 846 DPM against about 810 for assassins, while tanks and support mages fall well below on both GPM and DPM. `summary_stats.csv` holds the overall distribution.
- **Dashboard (`VISUALIZATION CHAMPION ROLE.pbix`):** a Power BI report of role-level performance and engagement metrics.

## Modeling

`forecast.ipynb` standardizes the 11 features and runs a stratified 80/20 split, then compares three classifiers that predict a game's champion role from behavior alone:

| Model | Accuracy | Macro F1 |
|---|---|---|
| Random Forest | 0.70 | 0.62 |
| Gradient Boosting | 0.70 | 0.62 |
| KNN | 0.60 | 0.40 |

- The tree models are clearly better than KNN.
- Minority roles (Support, Marksman, Tank, each with ≤ 13 test games) have high precision but low recall. More data or class weighting is the next step.
- The best model and its preprocessing are saved as `best_model.pkl`, `scaler.pkl` and `label_encoder.pkl`.

**Recommendation step:** given a Riot ID, the notebook fetches that player's 5 most recent games, averages the same 11 features, and predicts the role whose behavior they match. The full write-up is in `RECOMMEND CHAMPION SYSTEM .docx`.

## Run

Install the requirements:

```bash
pip install pandas numpy scikit-learn matplotlib seaborn requests python-dotenv joblib openpyxl xlrd
```

Then set your Riot API key in the first cell: `riot_api_key` in `sandbox.ipynb` and `riot_api_key1` in `forecast.ipynb`. Run the notebooks in this order: `sandbox` → `statistic` → `forecast`. They use absolute Windows paths, so point `file_path` at your local copy.

---

Not endorsed by Riot Games. League of Legends is a trademark of Riot Games, Inc.
