
# Diagnosing Instrument Exogeneity with Pretest-Posttest Designs

This repository provides simulation code and supplemental materials for the poster presentation:  
**“Diagnosing Instrument Exogeneity in Nonparametric Settings: A Comparison of IV and DiD.”**

---

## 🔍 Overview

This project explores whether **violations of the exogeneity assumption** in Instrumental Variable (IV) estimation can be empirically diagnosed by comparing it to **Difference-in-Differences (DiD)** estimates in **nonparametric settings**.

While IV and DiD rely on fundamentally different identification strategies (independence & exclusion restriction for IV; parallel trends for DiD), they may estimate the **same causal quantity**—the Average Treatment Effect on the Treated (ATT)—under **one-sided noncompliance**.

> Therefore, the agreement between IV and DiD may offer **diagnostic value** regarding IV exogeneity, even if DiD is imperfect.

---

## 📌 Motivation

- In **parametric settings**, violations of the **common trend assumption** in gain score analysis can be **corrected using a compass variable**.  
  ▶ See: [Kim, Gwak, & Lee, 2022](https://www.dbpia.co.kr/Journal/articleDetail?nodeId=NODE11232745)

- When this correction is applied, **discrepancies between IV and DiD** can be used to test the **independence assumption** of IV (i.e., IV ⫫ confounders), offering **indirect empirical evidence** of IV validity.

- In **nonparametric settings**, however, the compass method requires **ratio-based corrections**, which may result in **large standard errors** and unstable inference.

> 🧪 This project uses **Monte Carlo simulations** to examine how violations of IV exogeneity and DiD's common trends affect the **agreement between estimators** under one-sided noncompliance.

---

## 📌 Summary of Findings

- When **common trends hold**, IV and DiD estimates align **only if** the instrument is **truly exogenous**.  
- When **both assumptions fail**, random agreement between IV and DiD is **rare**, suggesting that **similar estimates are unlikely to result from shared misspecification**.
- Thus, **DiD can serve as a reference** to assess IV plausibility, especially when targeting the same causal estimand (ATT) under one-sided noncompliance.

---

## 🧾 Reference Materials

### 1. Correction Method for Common Trend Violation
> Kim, Y., Gwak, N., & Lee, S. (2022).  
> *Detection of and Correction for Violation of the Common Trend Assumption in Gain Score Analysis*  
> *Journal of Education Evaluation, 35(4), 743–761.*  
> [[Paper link]](https://www.dbpia.co.kr/Journal/articleDetail?nodeId=NODE11232745)

### 2. Presentation : Testing Exogeneity of Instrumental Variables Using Pretest-Posttest Designs
> *Comparing IV Estimates to Adjusted DiD Estimates*  
> This presentation focuses on the diagnostic potential of estimator agreement, particularly when the common trends assumption can be **defended or adjusted** in gain score analysis.

---

## 💻 Simulation Code

This repository includes R scripts that reproduce all simulation results used in the poster:

- IV estimation under one-sided noncompliance  
- DiD estimation under common trend assumption  
- Monte Carlo simulations for agreement patterns  
- Bootstrap procedures for uncertainty quantification

> 📁 Code available in the `/simulation/` directory.

---

## 🙌 Contact

This study is still ongoing. If you have any thoughts, suggestions, or critiques—especially about:
- Improving compass corrections in nonparametric contexts  
- Alternative strategies for testing IV assumptions empirically  
- Applications to education, policy, or observational studies  

please feel free to reach out:

📧 **naram.gwak@gmail.com**
