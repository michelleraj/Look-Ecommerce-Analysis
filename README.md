# Look-Ecommerce-Analysis

## 📊 Executive Summary
This project delivers a complete business intelligence solution for Look E-commerce, transforming raw data into actionable strategic insights. Through advanced SQL analytics, cohort analysis, and customer segmentation, I've identified critical growth opportunities and operational optimizations

### 🛠️ Technical Stack
- **SQL**: BigQuery, Advanced Window Functions, CTEs, Cohort Analysis
- **Analysis Types**: RFM Segmentation, Funnel Analysis, Time Series
- **Business Metrics**: CLV, CAC, Retention, Conversion Rates

<img width="1331" height="1141" alt="image" src="https://github.com/user-attachments/assets/635f977c-3d05-4548-a1ca-51beb9a9f938" />

---

### 💡 Customer Behavior & Retention - Cohort Analysis 
#### How loyal are our customers? What percentage make repeat purchases?
It separates new vs. returning customer behavior, showing true loyalty beyond one-time purchases.Business Question Answered: "Are we building a loyal customer base, or just constantly spending to replace churned customers?"

<img width="751" height="397" alt="Screenshot 2025-10-01 at 10 30 54 PM" src="https://github.com/user-attachments/assets/1f858d8e-b87f-412a-968c-01ab661b5e5a" />

Cohort size: ~27.4k customers have made at least one completed order.

Second-order retention: Only 3.2k customers (≈11.8%) came back for a second purchase.

One-time buyers dominate: Nearly 9 out of 10 customers churn after their first order, showing a heavy reliance on first-time acquisition rather than repeat business.

Growth opportunity: Even a modest uplift in repeat purchase rate (e.g., from ~12% → 20%) would translate into thousands of extra orders without acquiring new customers.

---
### 📊 Conversion Funnel Analysis
Mapping the step-by-step journey users take from first visit to purchase, measuring drop-offs at each stage.  Identifies exactly where potential customers are lost. A business might have great traffic but a broken checkout process - this analysis finds those specific breakdowns. Where in our customer journey are we losing the most people, and what should we fix first?"

<img width="899" height="691" alt="Screenshot 2025-10-13 at 2 52 15 PM" src="https://github.com/user-attachments/assets/e5564471-64b9-4415-9f7e-77333cc860e8" />

- **100% Session Engagement**: Every visitor views products
- **63.3% Cart Addition Rate**: Strong purchase intent from viewers  
- **42.1% Checkout Completion**: Major drop-off at final step
- **57.9% Cart Abandonment**: 232,741 lost potential orders
- **26.6% Overall Conversion**: 1 in 4 sessions result in purchase
- **Priority Fix**: Guest checkout & abandoned cart emails

### 🚚 Shipping & Delivery Efficiency Insights
#### How efficient is supply chain?
Measuring the time and cost of delivering your core service - in e-commerce, this is the "order-to-delivery" timeline. Slow delivery is a major reason for cart abandonment and poor customer satisfaction. Tracking this helps balance speed vs. cost. Is our supply chain meeting customer expectations for delivery speed? 

<img width="788" height="554" alt="Screenshot 2025-10-01 at 10 39 32 PM" src="https://github.com/user-attachments/assets/def88350-5877-401f-97c0-f5b5b8f624fd" />


The business is running a fairly quick order cycle: from purchase to delivery in under 4 days on average.

The largest chunk of time is in transit (≈2 days) rather than internal processing (≈1 day).

With 31k completed orders, this looks like a stable operational baseline rather than an outlier.

---
### 📈 Marketing Performance
#### Where should we be investing our marketing budget?

Understanding which marketing channels (Email, Social, etc.) drive valuable actions, not just clicks. Prevents wasting budget on channels that look popular but don't convert. Helps answer "Should we spend more on Instagram ads or email marketing? "Where should we invest our next marketing dollar for the highest return?"

<img width="1222" height="563" alt="Screenshot 2025-10-01 at 10 40 58 PM" src="https://github.com/user-attachments/assets/d0c5ec9d-18ab-441d-9918-3ef32db5c55d" />

Conversion rates are stable across channels (~26–27%)
– Very little variance between Email, Adwords, Social, and Organic.
– Suggests product appeal is strong regardless of entry point.

Email drives the largest volume
– 306k sessions, 52k orders, the top contributor to sales.
– Strong retention or customer list quality is a likely factor.

Adwords is the second-largest driver
– 203k sessions, 39k orders.
– Paid acquisition is performing as well as Email in terms of CVR, but likely more costly.

---
<img width="1115" height="443" alt="Screenshot 2025-09-20 at 6 32 49 PM" src="https://github.com/user-attachments/assets/4210c87d-5993-4bc9-bfa3-0d52fdf42841" />

📊 Data Coverage & Scale

- Total events logged: ~2.43 million
- Total sessions tracked: ~682k
- Total unique users with events: ~80k

⏱ Time Range

- Earliest event: Jan 2, 2019
- Latest event: Oct 6, 2025

---
### 📊 Event Type Analysis
We analyzed the distribution of event types in the **TheLook E-Commerce dataset** to understand how customers interact with the platform.
Categorizing and counting all user interactions (views, carts, purchases) to understand overall platform engagement. Reveals whether users are just browsing or actually intending to buy. A site with high views but no carts has very different problems than one with high carts but no purchases. "How are people actually using our platform, and where do they spend their time?"

<img width="1160" height="494" alt="Screenshot 2025-09-20 at 6 33 48 PM" src="https://github.com/user-attachments/assets/b8f6f873-8996-4aaa-b71e-349274d2e636" />

### 🔑 Key Insights

- **Browsing dominates** → ~60% of all events are product or department views, showing customers spend significant time exploring before purchase.  
- **Strong cart engagement** → ~25% of events involve adding items to the cart, indicating high intent to buy.  
- **Purchase conversion** → ~7.5% of all events result in a purchase, which is relatively healthy given the browsing-heavy behavior.  
- **Cancellations matter** → 5% of events are cancellations, suggesting a need to optimize the post-purchase experience (returns, refunds, order accuracy).  

### 📈 Strategic Implications

- Improve **product discovery** (search, recommendations, navigation) to shorten the path from browse → cart.

---
### 👥 User Segmentation & Friction Analysis. Logged-in Users vs. Visitors
Comparing behavior between different user groups (known vs. unknown) to identify experience barriers. Often reveals hidden conversion barriers - like requiring account creation before purchase, which can cause anonymous users to abandon carts.

<img width="1110" height="683" alt="Screenshot 2025-09-20 at 6 45 24 PM" src="https://github.com/user-attachments/assets/db2902d6-c8a5-41d4-bb9e-707bfaa4d5a5" />

#### 🔑 Key Insights

- **Anonymous visitors dominate browsing**  
  - 500k product views and 250k cart actions are from users who never log in.  
  - They also generate all **cancellation events (124k)**, suggesting they attempt transactions but often churn.  
- **Purchases only happen with logged-in users**  
  - All 182k purchase events are from known users — logging in is a requirement to complete checkout.  
- **Known users engage more deeply**  
  - Even though they generate fewer total events than visitors, logged-in users show balanced activity across browsing, carting, and purchasing.  
  - The **homepage (87k events)** is mainly visited by known users, possibly as part of return sessions.
### 🔑 Balanced Strategy

- **Guest Checkout = Capture Revenue Now**  
  - Prevents losing sales from high-intent anonymous visitors.  
- **Membership System = Build Retention Later**  
  - Encourages guest buyers to convert into loyal, trackable customers.
    
---
 
## 🚀 Strategic Recommendations
1. **Implement Guest Checkout** - Capture 124K anonymous cancellations
2. **Launch Retention Campaigns** - Target 27.4K first-time buyers  
3. **Optimize Marketing Budget** - Shift focus to Email channel
4. **Cart Abandonment Flow** - Recover 232K+ lost orders


