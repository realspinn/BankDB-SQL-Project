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

## Strategic Analyst Questions

Each question is designed to simulate a real-world business scenario. The section includes **Why** the question is important and **How** it is approached using SQL.

### 1. Who are the top 10 highest net worth customers?

**Why:** To identify high-value clients for premium banking services.  
**How:** Aggregate total balances from `Accounts`, group by customer, and join with `Customers`.

---

### 2. What customer segments are associated with the highest loan defaults?

**Why:** To assess and reduce credit risk.  
**How:** Filter `Loans` where `status = 'Defaulted'`, join with `Customers` for demographic analysis.

---

### 3. Which branches or employees manage the most accounts?

**Why:** For staffing and resource allocation decisions.  
**How:** Join `Employees` and `Accounts`, group by `branch` or `employee_id`, and count.

---

### 4. How many accounts have been frozen or closed in the past 6 months?

**Why:** To monitor churn and account issues.  
**How:** Query `Accounts` where `status` IN ('Frozen', 'Closed') and use date filter on `created_at`.

---

### 5. What’s the total projected monthly interest income from active loans?

**Why:** To predict monthly revenue flow.  
**How:** Calculate interest (`loan_amount * interest_rate`) for `Active` loans and group by month.

---

### 6. What transaction types are most common, and in which periods?

**Why:** To understand customer behavior and improve banking features.  
**How:** Group by `transaction_type` and time window (`DATE_TRUNC('month', transaction_date)`).

---

### 7. Which accounts have unusually high transaction frequencies?

**Why:** For fraud detection or to identify power users.  
**How:** Count transactions per `account_id`, order by frequency, and compare with average activity.

---

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

##  Next Steps

- Build visual dashboards using Power BI or Metabase
- Explore triggers and stored procedures for automation
- Simulate user access roles and security practices
- Push data via API endpoints for integration testing

---

##  Contact

**Israel Adeleye**  
SQL Developer | Aspiring DBA | Strategic Data Analyst  
[LinkedIn](https://www.linkedin.com/in/israel-adeleye-a466b5357/)
