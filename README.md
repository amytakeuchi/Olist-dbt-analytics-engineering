# 📊 Olist Analytics Engineering Project

## End-to-End Ecommerce Data Warehouse using dbt & BigQuery

---

## 🚀 Overview

This project demonstrates an end-to-end Analytics Engineering workflow using the Olist Ecommerce Dataset and a modern data stack centered around dbt and Google BigQuery.

The objective is to transform raw ecommerce transaction data into a clean, tested, and analytics-ready warehouse that supports business reporting, KPI tracking, and downstream BI applications.

This project follows Analytics Engineering best practices:

* Layered dbt architecture (Staging → Intermediate → Marts)
* Modular SQL transformations
* Data quality testing
* Star schema design
* Business metric standardization
* Git-based version control

---

## 🎯 Business Problem

Operational ecommerce databases are optimized for transactions, not analytics.

Common challenges include:

* Business metrics are inconsistently defined
* Complex joins are repeatedly written by analysts
* Raw tables are difficult to query efficiently
* No centralized source of truth exists

This project solves these issues by creating an analytics warehouse that enables:

* Revenue reporting
* Customer behavior analysis
* Product performance tracking
* Seller performance analysis
* Delivery and operational KPI monitoring

---

## 🏗️ Data Architecture

```text
Raw Data (BigQuery)
        │
        ▼
Staging Models (stg_*)
        │
        ▼
Intermediate Models (int_*)
        │
        ▼
Mart Models (fct_* / dim_*)
        │
        ▼
BI & Analytics Layer
```

### Dataset Structure

```text
olist_dev_staging
    ↓
olist_dev_intermediate
    ↓
olist_dev
```

---

## 🧰 Technology Stack

| Layer           | Tool                    |
| --------------- | ----------------------- |
| Data Warehouse  | Google BigQuery         |
| Transformation  | dbt                     |
| Language        | SQL + Jinja             |
| Version Control | Git & GitHub            |
| Documentation   | dbt Docs                |
| BI Layer        | Tableau / Looker Studio |

---

## 📦 Source Dataset

The project uses the Olist Ecommerce Dataset containing:

* Orders
* Customers
* Order Items
* Payments
* Products
* Sellers
* Reviews
* Geolocation

### Raw Tables

```text
orders_raw.orders_raw
orders_raw.customers_raw
orders_raw.order_items_raw
orders_raw.payments_raw
orders_raw.products_raw
orders_raw.sellers_raw
```

---

# 🔄 dbt Project Structure

```text
olist_dbt/
│
├── models/
│
├── staging/
│   ├── stg_orders.sql
│   ├── stg_customers.sql
│   ├── stg_order_items.sql
│   ├── stg_payments.sql
│   ├── stg_products.sql
│   └── stg_sellers.sql
│
├── intermediate/
│   ├── int_orders_enriched.sql
│   ├── int_order_revenue.sql
│   ├── int_order_payments.sql
│   ├── int_order_items_enriched.sql
│   └── int_customer_orders.sql
│
├── marts/
│   ├── fct_orders.sql
│   ├── fct_revenue.sql
│   ├── fct_product_sales.sql
│   ├── fct_category_performance.sql
│   ├── dim_customers.sql
│   ├── dim_products.sql
│   └── dim_sellers.sql
│
├── tests/
├── macros/
├── snapshots/
└── seeds/
```

---

# 🧱 Data Modeling Strategy

## Staging Layer (`stg_*`)

Purpose:

* Clean raw source data
* Rename columns
* Standardize naming conventions
* Cast data types
* Remove duplicates
* Handle null values

Example:

```sql
stg_orders
```

Represents a cleaned version of:

```sql
orders_raw.orders_raw
```

---

## Intermediate Layer (`int_*`)

Purpose:

Create reusable business entities and transformation logic.

Examples:

### int_order_revenue

Calculates:

* Item Revenue
* Freight Revenue
* Gross Revenue

### int_order_items_enriched

Combines:

* Products
* Categories
* Revenue calculations

### int_customer_orders

One row per order enriched with:

* Customer information
* Delivery metrics
* Revenue metrics
* Order lifecycle attributes

These models are reusable building blocks used across multiple mart models.

---

## Mart Layer (`fct_*` and `dim_*`)

Purpose:

Provide business-facing tables optimized for reporting and analytics.

### Fact Tables

#### fct_orders

Grain:

```text
1 row per order
```

Contains:

* Order details
* Customer information
* Revenue
* Delivery metrics

---

#### fct_revenue

Revenue-focused fact table containing:

* Gross Revenue
* Item Revenue
* Freight Revenue

---

#### fct_product_sales

Business question:

> Which products generate the most revenue?

Metrics:

* Orders
* Revenue
* Average Selling Price

---

#### fct_category_performance

Business question:

> Which product categories drive revenue?

Metrics:

* Revenue
* Orders
* Average Order Value

---

### Dimension Tables

#### dim_customers

One row per customer.

Includes:

* First Order Date
* Last Order Date
* Total Orders
* Lifetime Revenue
* Average Order Value
* Repeat Customer Flag

---

#### dim_products

One row per product.

Includes:

* Product Category
* Product Attributes

---

#### dim_sellers

One row per seller.

Includes:

* Seller Information
* Seller Performance Metrics

---

# 📊 Core Business Metrics

## Revenue Metrics

* Total Revenue
* Revenue by Category
* Revenue by Product
* Revenue by Seller

## Customer Metrics

* Customer Lifetime Value (CLV)
* Repeat Purchase Rate
* Average Order Value (AOV)
* New vs Returning Customers

## Product Metrics

* Best Selling Products
* Best Selling Categories
* Product Revenue Contribution

## Operations Metrics

* Delivery Time
* Late Delivery Rate
* Order Fulfillment Performance

---

# 🧪 Data Quality Testing

Implemented dbt tests include:

## Generic Tests

```yaml
- unique
- not_null
- relationships
```

### Example

```yaml
columns:
  - name: order_id
    tests:
      - unique
      - not_null
```

---

## Business Logic Tests

* Revenue must be non-negative
* Valid order status values
* Orders must have valid customers
* Revenue calculations must reconcile

---

# 📈 Example Analytics Use Cases

The warehouse supports:

### Revenue Analysis

* Monthly Revenue Trends
* Revenue by Category
* Revenue by Seller

### Customer Analytics

* Customer Cohorts
* Customer Retention
* Repeat Purchase Behavior

### Product Analytics

* Category Performance
* Product Revenue Ranking
* Product Mix Analysis

### Operations Analytics

* Delivery Performance
* Delivery Delays
* Review Score Impact Analysis

---

# ⚙️ Running the Project

## 1. Clone Repository

```bash
git clone https://github.com/your-username/olist-analytics-engineering.git

cd olist-analytics-engineering
```

## 2. Install Dependencies

```bash
pip install dbt-bigquery
```

## 3. Configure dbt Profile

Update:

```text
~/.dbt/profiles.yml
```

with your:

* GCP Project ID
* Dataset
* Credentials

---

## 4. Execute Models

```bash
dbt run
```

---

## 5. Execute Tests

```bash
dbt test
```

---

## 6. Generate Documentation

```bash
dbt docs generate
dbt docs serve
```

---

# 📌 Key Design Decisions

### Layered Architecture

```text
stg_* → int_* → marts
```

Benefits:

* Modular design
* Reusable transformations
* Easier debugging
* Better maintainability

### Star Schema Modeling

Fact tables store business events.

Dimension tables provide descriptive attributes.

Benefits:

* Faster BI queries
* Easier dashboard development
* Consistent KPI definitions

### Separation of Concerns

Intermediate models:

* Reusable transformations

Mart models:

* Business-facing KPIs

---

# 🚀 Future Enhancements

Planned improvements:

* Incremental dbt models
* Snapshot implementation
* CI/CD via GitHub Actions
* Airflow orchestration
* Data observability monitoring
* Automated documentation deployment
* Tableau / Looker dashboards

---

# 📚 Key Analytics Engineering Concepts Demonstrated

* Data Modeling
* Star Schema Design
* Fact & Dimension Modeling
* Analytics Engineering Best Practices
* dbt Layered Architecture
* Data Quality Testing
* BigQuery Optimization
* KPI Standardization
* SQL Transformation Development

---

# 👤 Author

**Asami Takeuchi**

Analytics | Data Science | Analytics Engineering

LinkedIn: [Add Link]

GitHub: [Add Link]

---

⭐ If you found this project helpful, please consider starring the repository.
