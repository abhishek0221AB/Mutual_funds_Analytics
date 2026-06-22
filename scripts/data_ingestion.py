import pandas as pd
import os

# Create folder if not exists
os.makedirs("data/raw", exist_ok=True)

datasets = {
    "fund_master":            "1vxvhJB2gVKsLfv51pXcLa39hnOr7M6vZ",
    "nav_history":            "10GfFYNtj-yqUoJ05zxkFhti0DkEW_CuZ",
    "aum_by_fund_house":      "1SY1wVj6aU3coZcPVE5DuWxUOj5mtUP4T",
    "monthly_sip_inflows":    "1NoQEbNNZyenLShtBM4CRjrh6c5lhx5Qy",
    "category_inflows":       "1M-OqSJBEz-so0Q69PzMZBq10ON_WaI17",
    "industry_folio_count":   "1rgkdnDbv0GcjZgfdczqr7kkVB7cGBz4s",
    "scheme_performance":     "1N65c5EcrgYQmDJUAs8cxyZnp9WV10izk",
    "investor_transactions":  "1zRk1hIJ1gF2vmmYbXFuKmpaFDzTiFIFj",
    "portfolio_holdings":     "1O2cXuQhc8SMOcYY38fCJF7IErOqaP6iv",
    "benchmark_indices":      "13VZkUoJlyXADh3M9kbaXLi9cVEJs_76s",
}

dataframes = {}

for name, fid in datasets.items():
    url = f"https://drive.google.com/uc?export=download&id={fid}"
    df = pd.read_csv(url)
    dataframes[name] = df

    
    df.to_csv(f"data/raw/{name}.csv", index=False)

    print(f"\n{'='*40}")
    print(f"Dataset : {name}")
    print(f"Shape   : {df.shape}")
    print(f"Dtypes  :\n{df.dtypes}")
    print(f"Head    :\n{df.head()}")
    print(f"Saved → data/raw/{name}.csv")  