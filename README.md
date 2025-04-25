# BankDB - SQL Banking Database Project

## About Me

I'm **Israel Adeleye**, a passionate SQL Developer and aspiring **Database Administrator** focused on building scalable, optimized, and real-world-ready database systems. This is my **third major SQL project**, following my Amazon e-commerce and Spotify clone datasets. I'm especially focused on performance tuning, indexing, and strategic analytics. All development was done using **PostgreSQL** and **VS Code**.

**LinkedIn:** [https://www.linkedin.com/in/israel-adeleye-a466b5357/](https://www.linkedin.com/in/israel-adeleye-a466b5357/)

---

##  Project Overview

**BankDB** is a performance-oriented relational database designed to simulate a realistic banking system. It covers essential operations such as customer profiling, account types, transaction history, loan tracking, and employee records.

This project includes:

- **Over 60,000 inserted records** with no ID conflicts or foreign key violations
- **Strategic indexing** to optimize query performance
- Real-world **business analyst questions** answered via SQL
- Schema integrity and normalization best practices

---

## Tools & Tech Stack

- **PostgreSQL**
- **Visual Studio Code**
- **pgAdmin** (for visual testing)
- **Git & GitHub** (for version control and collaboration)

---

##  Schema Design

### Key Tables:
| Table Name     | Description |
|----------------|-------------|
| `Customers`    | Holds customer profile data |
| `Accounts`     | Tracks various account types and balances |
| `Transactions` | Logs transactions with descriptions and timestamps |
| `Employees`    | Stores employee and branch information |
| `Loans`        | Records customer loans, types, and statuses |

### Design Highlights:
- All foreign keys use `ON DELETE CASCADE` and `ON UPDATE CASCADE`
- `CHECK` constraints on enumerated values like account types, loan types, and statuses
- `IDENTITY` columns for unique, auto-incrementing primary keys
- `NOT NULL`, `UNIQUE`, and `DEFAULT` values added where needed

---

## Indexing Strategy

The following **unclustered indexes** were created to optimize query performance for JOINs and WHERE clauses:

| Table        | Indexed Columns                   | Reason |
|--------------|------------------------------------|--------|
| `Customers`  | `email`, `phone_number`           | Fast lookups and uniqueness |
| `Accounts`   | `customer_id`, `account_type`, `status` | Commonly queried and filtered |
| `Transactions` | `account_id`, `transaction_date`   | For time-based analysis and account tracing |
| `Loans`      | `customer_id`, `loan_type`, `status` | Support reporting and risk checks |

---

## Strategic Analyst Questions (With Why & How)

This section lists the **core business problems** we’re solving using SQL — as a Strategic Analyst would — along with **why they matter** and **how** we derive answers using the BankDB schema.

---

### 1. Customer-Based Insights

**Why?**  
To better understand customer behavior and their financial profiles.

**How?**  
By analyzing data across `Customers`, `Accounts`, and `Loans` tables.

- **Which type of customers hold the highest balances?**  
  → Group by age/address/DOB and aggregate balances per customer.

- **Are older customers more reliable with loan repayments?**  
  → Compare age of customers with their loan `status` (Repaid vs Defaulted).

- **Do people with multiple accounts behave differently?**  
  → Count how many accounts each customer holds and analyze total balances or loan presence.

---

### 2. Account-Based Analysis

**Why?**  
To optimize account offerings and identify user patterns.

**How?**  
By querying the `Accounts` and `Transactions` tables.

- **Which account type holds the most money overall?**  
  → Group by `account_type`, sum balances.

- **How many accounts are Active, Frozen, or Closed?**  
  → Count `status` groups and investigate reasons for frozen/closed accounts.

- **What’s the average time between account creation and first transaction?**  
  → Compare `created_at` in `Accounts` with earliest `transaction_date`.

---

### 3. Transaction-Based Analysis

**Why?**  
To monitor money movement, flag inactivity, and detect anomalies.

**How?**  
Through queries on the `Transactions` table with grouping and filtering logic.

- **What’s the most common transaction type?**  
  → Count of `transaction_type`.

- **Are some accounts inactive?**  
  → Identify accounts with no transactions over a period.

- **Do some accounts show high daily volume (potential fraud)?**  
  → Group by `account_id` and `transaction_date`, count rows per day.

---

### 4. Loan-Based Evaluation

**Why?**  
To manage risk, reduce defaults, and understand loan performance.

**How?**  
By joining `Loans`, `Customers`, and `Accounts`.

- **Which loan type has the highest default rate?**  
  → Group by `loan_type` and compare `status`.

- **Does higher interest rate lead to more defaults or better repayment?**  
  → Analyze `interest_rate` against `status`.

- **Are loan-takers also big savers?**  
  → Join `Loans` with `Accounts` by `customer_id` and compare balances.

---

### 5. Employee/Branch Performance (Future Scope)

**Why?**  
To evaluate employee contributions and branch impact.

**How?**  
Once `employee_id` is added as FK to `Accounts` or `Loans`.

- **Which employees opened the most accounts/loans?**  
  → Count by `employee_id`.

- **Which branches bring in high-balance customers?**  
  → Group balances by `branch`.

---

## Performance Optimization

- **Indexes Used:**  
  Non-clustered indexes created on high-usage columns like `customer_id`, `account_id`, `loan_id`, and `transaction_date` for faster JOINs and WHERE clauses.

- **Why Indexing?**  
  To ensure high-speed queries on a large 60k dataset and reduce table scan time.

---

## What I Learned

- Real-world database design and optimization strategies  
- Writing scalable SQL queries for business intelligence  
- Importance of indexes in query performance  
- Customer segmentation and risk analysis from a banking lens


## File Structure

| File Name              | Description |
|------------------------|-------------|
| `BankDB_Schema.sql`    | Full schema creation: tables, constraints, data types |
| `BankDB_Insert.sql`    | Data generation script for 60k+ records |
| `BankDB_Indexes.sql`   | All index creation statements |
| `BankDB_Queries.sql`   | Strategic SQL questions and queries |
| `README.md`            | Project documentation (this file) |

---

##  Outcomes

- Built and populated a normalized banking schema with 60,000+ records
- Applied indexes that significantly improved query speed
- Practiced business-oriented SQL questioning and answering
- Strengthened database design and optimization fundamentals

---

### 🔜 Next Steps

- **Deepen knowledge on stored procedures and triggers**  
  → I plan to learn more about automating tasks (e.g., updating balances, triggering notifications) to optimize database performance. Right now, my understanding is at a basic level.

- **Explore API integration**  
  → Eventually, I’ll connect my database to a frontend or external services, but I’m still learning APIs, so this is for future enhancement.

- **Advanced query optimization**  
  → I aim to further optimize complex queries for performance, focusing on techniques such as query profiling and execution plans.

- **User roles & security enhancements**  
  → Implement more granular access controls and security measures to ensure different user roles (e.g., customers, employees) have appropriate permissions.
  
---

##  Contact

**Israel Adeleye**  
SQL Developer | Aspiring DBA | Strategic Data Analyst  
[LinkedIn](https://www.linkedin.com/in/israel-adeleye-a466b5357/)






