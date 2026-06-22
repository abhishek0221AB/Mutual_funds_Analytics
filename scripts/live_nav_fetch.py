import requests
import pandas as pd
import os

schemes = {
    "HDFC_Top_100": "125497",
    "SBI_Bluechip": "119551",
    "ICICI_Bluechip": "120503",
    "Nippon_Large_Cap": "118632",
    "Axis_Bluechip": "119092",
    "Kotak_Bluechip": "120841",
}

os.makedirs("data/raw", exist_ok=True)

all_navs = []
for fund_name, code in schemes.items():
    url = f"https://api.mfapi.in/mf/{code}"
    response = requests.get(url)
    data = response.json()

    # Extract Scheme info
    meta = data["meta"]
    nav_records = data["data"]

    # Convert to DataFrame
    df = pd.DataFrame(nav_records)
    df["scheme_code"] = code
    df["scheme_name"] = meta["scheme_name"]
    df["scheme_code"] = meta["scheme_code"]
    # Save individual scheme NAVs to CSV
    filename = f"data/raw/navs_{fund_name}.csv"
    df.to_csv(filename, index=False)
    all_navs.append(df)
    print(f"{fund_name}: {len(df)} rows saved to {filename}")

# Combine all into one master CSV
master_df = pd.concat(all_navs, ignore_index=True)
master_df.to_csv("data/raw/all_nav_live .csv", index=False)

print(f"Master NAV file saved -> data/raw/all_nav_live.csv ")
print(f"Total rows:{master_df.shape[0]}")
print(master_df.head())