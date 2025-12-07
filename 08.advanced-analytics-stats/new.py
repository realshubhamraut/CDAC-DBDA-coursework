# %% [markdown]
"""
#### credit risk case study

this notebook performs data cleaning, feature engineering, exploratory analysis and hypothesis testing on the credit risk datasets
"""

# %%
import os

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
import seaborn as sns

from scipy import stats
import statsmodels.api as sm

from tabulate import tabulate
from colorama import Fore, Style

pd.set_option("display.max_columns", 200)
pd.set_option("display.float_format", lambda x: f"{x:0.4f}")
sns.set(style="whitegrid")

# %% [markdown]
"this cell imports main libraries for data handling, plots and statistical tests"

# %%
# download datasets into /content/datasets (for colab users)
folder_path = "/content/datasets"
os.makedirs(folder_path, exist_ok=True)

base_url = "https://media.githubusercontent.com/media/realshubhamraut/CDAC-DBDA-coursework/refs/heads/main/08.advanced-analytics-stats/data/"
files = [
    "credit_risk_applicants.csv",
    "credit_risk_metadata.csv",
    "credit_risk_previous_loans.csv"
]

for f in files:
    url = base_url + f
    save_path = os.path.join(folder_path, f)
    print(f"downloading: {f}")
    os.system(f'wget -q "{url}" -O "{save_path}"')

print("download complete.")

app_path = os.path.join(folder_path, "credit_risk_applicants.csv")
meta_path = os.path.join(folder_path, "credit_risk_metadata.csv")
loans_path = os.path.join(folder_path, "credit_risk_previous_loans.csv")

app = pd.read_csv(app_path, encoding="latin-1")
meta = pd.read_csv(meta_path, encoding="latin-1")
loans = pd.read_csv(loans_path, encoding="latin-1")

app.shape, loans.shape, meta.shape

# %% [markdown]
"this cell downloads the datasets from github and loads them into pandas dataframes"

# %%
print("applicants head")
display(app.head())
print("\napplicants info")
app.info()

print("\nprevious loans head")
display(loans.head())
print("\nprevious loans info")
loans.info()

print("\nmetadata head")
display(meta.head())

# %% [markdown]
"this cell gives a quick view of structure and sample rows for each dataset"

# %%
def missing_details(df, name, top_n=None):
    total = len(df)
    count = df.isna().sum()
    pct = (count / total * 100).round(2)

    summary = (
        pd.DataFrame({"feature": df.columns,
                      "missing_count": count,
                      "missing_percent": pct})
        .sort_values("missing_percent", ascending=False)
    )

    if top_n is not None:
        to_show = summary.head(top_n)
    else:
        to_show = summary

    print(f"\nmissing details for {name}\n")
    print(tabulate(to_show, headers="keys", tablefmt="grid", showindex=False))
    return summary


def missing_overview(df1, name1, df2, name2):
    p1 = (df1.isna().sum() / len(df1) * 100).round(2)
    p2 = (df2.isna().sum() / len(df2) * 100).round(2)

    cats = [
        (">40% missing",    (p1 > 40).sum(),                 (p2 > 40).sum()),
        ("10–40% missing",  ((p1 > 10) & (p1 <= 40)).sum(),  ((p2 > 10) & (p2 <= 40)).sum()),
        ("0–10% missing",   ((p1 > 0) & (p1 <= 10)).sum(),   ((p2 > 0) & (p2 <= 10)).sum()),
        ("0% missing",      (p1 == 0).sum(),                 (p2 == 0).sum())
    ]

    rows = [
        [cat,
         f"{c1} ({c1/len(df1.columns)*100:.2f}%)",
         f"{c2} ({c2/len(df2.columns)*100:.2f}%)"]
        for cat, c1, c2 in cats
    ]

    print(Fore.BLUE + f"\nmissing overview: {name1} vs {name2}\n" + Style.RESET_ALL)
    print(tabulate(rows,
                   headers=["values missing", name1, name2],
                   tablefmt="grid"))


def full_missing_table(df1, name1, df2, name2, threshold=40):
    p1 = (df1.isna().sum() / len(df1) * 100).round(2)
    p2 = (df2.isna().sum() / len(df2) * 100).round(2)

    cols = sorted(set(df1.columns) | set(df2.columns))
    rows = []

    for col in cols:
        m1 = p1[col] if col in df1.columns else None
        m2 = p2[col] if col in df2.columns else None

        s1 = f"{m1:.2f}%" if m1 is not None else "-"
        s2 = f"{m2:.2f}%" if m2 is not None else "-"

        flag = "drop" if (
            (m1 is not None and m1 > threshold) or
            (m2 is not None and m2 > threshold)
        ) else "keep"

        rows.append([col, s1, s2, flag])

    print(f"\nfull missing table with flag for {name1} and {name2}\n")
    print(tabulate(rows,
                   headers=["column", f"{name1} missing %", f"{name2} missing %", "flag"],
                   tablefmt="grid",
                   showindex=False))

# %% [markdown]
"this cell defines helper functions to summarise missing values and to suggest drop or keep flags"

# %%
missing_overview(app, "applicants", loans, "previous loans")

app_missing = missing_details(app, "applicants", top_n=None)
loans_missing = missing_details(loans, "previous loans", top_n=None)

full_missing_table(app, "applicants", loans, "previous loans", threshold=40)

# %% [markdown]
"this cell inspects missingness in both datasets and prints a combined view with suggested flags"

# %% [markdown]
"""
#### note on keeping some high missing columns

some features are sparse but conceptually important for credit risk, so we do not drop them only because of high missing percentage:

- credit bureau count features `AMT_REQ_CREDIT_BUREAU_*` capture enquiry activity
- external scores `EXT_SOURCE_1`, `EXT_SOURCE_2`, `EXT_SOURCE_3` are highly predictive
- occupation and organization type capture socio economic segment
- property and region fields proxy long term wealth and location risk

we combine a numeric threshold with a manual keep list for such variables
"""

# %%
# calculate missing percentages for all columns
app_na_pct = app.isna().mean() * 100
loans_na_pct = loans.isna().mean() * 100

threshold = 40.0

important_app_cols = [
    "EXT_SOURCE_1", "EXT_SOURCE_2", "EXT_SOURCE_3",
    "OCCUPATION_TYPE", "ORGANIZATION_TYPE",
    "NAME_INCOME_TYPE", "NAME_EDUCATION_TYPE",
    "NAME_FAMILY_STATUS", "NAME_HOUSING_TYPE",
    "AMT_INCOME_TOTAL", "AMT_CREDIT", "AMT_ANNUITY",
    "TARGET", "SK_ID_CURR"
]

important_loans_cols = [
    "SK_ID_CURR", "SK_ID_PREV",
    "AMT_APPLICATION", "AMT_CREDIT", "AMT_ANNUITY",
    "AMT_GOODS_PRICE", "NAME_CONTRACT_TYPE",
    "NAME_CONTRACT_STATUS", "AMT_DOWN_PAYMENT",
    "RATE_DOWN_PAYMENT", "CNT_PAYMENT"
]

app_drop = [c for c in app.columns
            if app_na_pct[c] > threshold and c not in important_app_cols]

loans_drop = [c for c in loans.columns
              if loans_na_pct[c] > threshold and c not in important_loans_cols]

print("columns dropped from applicants:", len(app_drop))
print(app_drop[:25])
print("\ncolumns dropped from previous loans:", len(loans_drop))
print(loans_drop[:25])

app_clean = app.drop(columns=app_drop)
loans_clean = loans.drop(columns=loans_drop)

# %% [markdown]
"this cell drops very sparse columns based on a threshold but preserves a manual list of important features"

# %%
def impute_df(df):
    num_cols = df.select_dtypes(include=[np.number]).columns
    cat_cols = df.select_dtypes(exclude=[np.number]).columns

    for col in num_cols:
        df[col] = df[col].fillna(df[col].median())

    for col in cat_cols:
        if df[col].isna().any():
            mode_vals = df[col].mode(dropna=True)
            if len(mode_vals) > 0:
                df[col] = df[col].fillna(mode_vals[0])
    return df

app_clean = impute_df(app_clean.copy())
loans_clean = impute_df(loans_clean.copy())

app_clean.isna().sum().sum(), loans_clean.isna().sum().sum()

# %% [markdown]
"this cell applies median imputation for numeric features and mode for categorical features"

# %%
# engineer applicant age and employment duration
if "DAYS_BIRTH" in app_clean.columns:
    app_clean["AGE_YEARS"] = (-app_clean["DAYS_BIRTH"] / 365.25).round(1)

if "DAYS_EMPLOYED" in app_clean.columns:
    app_clean.loc[app_clean["DAYS_EMPLOYED"] > 0, "DAYS_EMPLOYED"] = np.nan
    app_clean["YEARS_EMPLOYED"] = (-app_clean["DAYS_EMPLOYED"] / 365.25)
    app_clean["YEARS_EMPLOYED"] = app_clean["YEARS_EMPLOYED"].fillna(
        app_clean["YEARS_EMPLOYED"].median()
    )

app_clean[["AGE_YEARS", "YEARS_EMPLOYED"]].describe()

# %% [markdown]
"this cell transforms negative day counts into interpretable age and employment duration in years"

# %%
# aggregate previous loans into customer level features
key_col = "SK_ID_CURR"
agg_dict = {}

if "AMT_CREDIT" in loans_clean.columns:
    agg_dict["AMT_CREDIT"] = ["mean", "max", "sum"]

if "AMT_APPLICATION" in loans_clean.columns:
    agg_dict["AMT_APPLICATION"] = ["mean", "max", "sum"]

if "CNT_PAYMENT" in loans_clean.columns:
    agg_dict["CNT_PAYMENT"] = ["mean", "max"]

if "DAYS_DECISION" in loans_clean.columns:
    agg_dict["DAYS_DECISION"] = ["mean", "min"]

prev_agg = loans_clean.groupby(key_col).agg(agg_dict)
prev_agg.columns = ["PREV_" + "_".join(col).upper() for col in prev_agg.columns]
prev_agg.reset_index(inplace=True)

# contract status one hot counts
if "NAME_CONTRACT_STATUS" in loans_clean.columns:
    status_dummies = pd.get_dummies(
        loans_clean[["SK_ID_CURR", "NAME_CONTRACT_STATUS"]],
        columns=["NAME_CONTRACT_STATUS"],
        prefix="PREV_STATUS"
    )
    status_agg = status_dummies.groupby("SK_ID_CURR").sum().reset_index()
    prev_agg = prev_agg.merge(status_agg, on="SK_ID_CURR", how="left")

prev_agg.head()

# %% [markdown]
"this cell summarises previous loans into aggregated credit, application and status features per customer"

# %%
# merge applicant and previous loans features
data = app_clean.merge(prev_agg, on="SK_ID_CURR", how="left")

num_cols_all = data.select_dtypes(include=[np.number]).columns
data[num_cols_all] = data[num_cols_all].fillna(0)

data.shape, data.head()

# %% [markdown]
"this cell creates the final analytical dataset by merging applicants with aggregated loan history"

# %%
# target distribution
if "TARGET" in data.columns:
    target_counts = data["TARGET"].value_counts()
    target_rate = data["TARGET"].mean()
    print("target counts")
    print(target_counts)
    print("\ndefault rate:", target_rate)

    plt.figure(figsize=(4, 3))
    sns.countplot(x="TARGET", data=data)
    plt.title("target distribution")
    plt.tight_layout()
    plt.show()

# %% [markdown]
"this cell checks the balance of default vs non default classes"

# %%
# numeric distributions
cols_to_plot = ["AMT_INCOME_TOTAL", "AMT_CREDIT", "AMT_ANNUITY", "AGE_YEARS"]

for col in cols_to_plot:
    if col in data.columns:
        plt.figure(figsize=(5, 3))
        sns.histplot(data[col], bins=50, kde=True)
        plt.title(f"{col.lower()} distribution")
        plt.tight_layout()
        plt.show()

# %% [markdown]
"this cell plots histograms of main numeric variables to inspect their spread and skew"

# %%
# compare means of some numeric variables by target
if "TARGET" in data.columns:
    compare_cols = [c for c in ["AMT_INCOME_TOTAL", "AMT_CREDIT", "AMT_ANNUITY", "AGE_YEARS"] if c in data.columns]
    if compare_cols:
        display(data.groupby("TARGET")[compare_cols].mean())

# %% [markdown]
"this cell compares average income, credit, annuity and age between defaulters and non defaulters"

# %%
# correlation of numeric features with target
if "TARGET" in data.columns:
    num_cols = [c for c in data.columns if data[c].dtype != "object"]
    corr = data[num_cols].corr()["TARGET"].sort_values(ascending=False)
    print("top positive correlations with target")
    print(corr.head(15))
    print("\ntop negative correlations with target")
    print(corr.tail(15))

# %% [markdown]
"this cell lists numeric features most positively and negatively correlated with the target"

# %%
# two sample t test: income defaulters vs non defaulters
if "TARGET" in data.columns and "AMT_INCOME_TOTAL" in data.columns:
    inc_def = data.loc[data["TARGET"] == 1, "AMT_INCOME_TOTAL"]
    inc_non = data.loc[data["TARGET"] == 0, "AMT_INCOME_TOTAL"]
    t_stat, p_val = stats.ttest_ind(inc_def, inc_non, equal_var=False)
    print("two sample t test for income by target")
    print("t statistic:", t_stat)
    print("p value:", p_val)

# chi square test: education vs target
if "TARGET" in data.columns and "NAME_EDUCATION_TYPE" in data.columns:
    edu_tab = pd.crosstab(data["NAME_EDUCATION_TYPE"], data["TARGET"])
    chi2, p, dof, exp = stats.chi2_contingency(edu_tab)
    print("\nchi square test for education vs target")
    print("chi2:", chi2, " p value:", p)

# one way anova: income across education levels
if "AMT_INCOME_TOTAL" in data.columns and "NAME_EDUCATION_TYPE" in data.columns:
    groups = [g["AMT_INCOME_TOTAL"].values for _, g in data.groupby("NAME_EDUCATION_TYPE") if len(g) > 1]
    if len(groups) > 1:
        f_stat, p_val = stats.f_oneway(*groups)
        print("\none way anova for income by education type")
        print("f statistic:", f_stat, " p value:", p_val)

# two sample proportion z test: gender difference in default
if "TARGET" in data.columns and "CODE_GENDER" in data.columns:
    tab = pd.crosstab(data["CODE_GENDER"], data["TARGET"])
    if tab.shape[0] >= 2 and 1 in tab.columns:
        g1, g2 = tab.index[0], tab.index[1]
        success = np.array([tab.loc[g1, 1], tab.loc[g2, 1]])
        total = tab.sum(axis=1).loc[[g1, g2]].values
        p1 = success[0] / total[0]
        p2 = success[1] / total[1]
        p_pool = success.sum() / total.sum()
        se = np.sqrt(p_pool * (1 - p_pool) * (1 / total[0] + 1 / total[1]))
        z_stat = (p1 - p2) / se
        p_val = 2 * (1 - stats.norm.cdf(abs(z_stat)))
        print("\ntwo sample proportion test for gender difference in default")
        print("z statistic:", z_stat, " p value:", p_val)

# one sample proportion: compare overall default rate to 10 percent benchmark
if "TARGET" in data.columns:
    n = len(data)
    x = (data["TARGET"] == 1).sum()
    p_hat = x / n
    p0 = 0.10
    se = np.sqrt(p0 * (1 - p0) / n)
    z_stat = (p_hat - p0) / se
    p_val = 1 - stats.norm.cdf(z_stat)
    print("\none sample proportion z test vs 10 percent benchmark")
    print("observed default rate:", p_hat)
    print("z statistic:", z_stat, " p value (one sided):", p_val)

# f test for variance of income between defaulters and non defaulters
if "TARGET" in data.columns and "AMT_INCOME_TOTAL" in data.columns:
    inc_def = data.loc[data["TARGET"] == 1, "AMT_INCOME_TOTAL"]
    inc_non = data.loc[data["TARGET"] == 0, "AMT_INCOME_TOTAL"]
    var_def = inc_def.var(ddof=1)
    var_non = inc_non.var(ddof=1)
    if var_def > var_non:
        f_stat = var_def / var_non
        dfn = len(inc_def) - 1
        dfd = len(inc_non) - 1
    else:
        f_stat = var_non / var_def
        dfn = len(inc_non) - 1
        dfd = len(inc_def) - 1
    p_val = 2 * min(stats.f.cdf(f_stat, dfn, dfd), 1 - stats.f.cdf(f_stat, dfn, dfd))
    print("\ntwo sample variance f test for income")
    print("f statistic:", f_stat, " p value:", p_val)

# approximate poisson rate comparison: children count for defaulters vs non defaulters
if "TARGET" in data.columns and "CNT_CHILDREN" in data.columns:
    cnt_def = data.loc[data["TARGET"] == 1, "CNT_CHILDREN"]
    cnt_non = data.loc[data["TARGET"] == 0, "CNT_CHILDREN"]
    lambda_def = cnt_def.mean()
    lambda_non = cnt_non.mean()
    rate_diff = lambda_def - lambda_non
    se = np.sqrt(lambda_def / len(cnt_def) + lambda_non / len(cnt_non))
    z_stat = rate_diff / se if se > 0 else np.nan
    p_val = 1 - stats.norm.cdf(z_stat) if not np.isnan(z_stat) else np.nan
    print("\ntwo sample poisson style z test for children count")
    print("lambda defaulters:", lambda_def, " lambda non defaulters:", lambda_non)
    print("z statistic:", z_stat, " p value (one sided):", p_val)

# %% [markdown]
"this cell runs t tests, proportion tests, chi square, anova, variance and poisson style tests to compare key groups"

# %% [markdown]
"""
#### summary

we explored missingness, cleaned and imputed the datasets, engineered features from applicant and previous loans data, and ran exploratory analysis and hypothesis tests to understand drivers of default
"""
